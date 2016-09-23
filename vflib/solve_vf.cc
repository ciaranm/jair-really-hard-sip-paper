/* vim: set sw=4 sts=4 et foldmethod=syntax : */

#include "argraph.h"
#include "argedit.h"
#include "argloader.h"
#include "match.h"
#include "vf2_mono_state.h"

#include <fstream>
#include <iostream>
#include <thread>
#include <condition_variable>
#include <mutex>
#include <atomic>
#include <cstdlib>
#include <chrono>
#include <vector>

#include <boost/regex.hpp>

using std::chrono::milliseconds;
using std::chrono::steady_clock;
using std::chrono::duration_cast;

class GraphFileError :
    public std::exception
{
    private:
        std::string _what;

    public:
        GraphFileError(const std::string & filename, const std::string & message) throw ();

        auto what() const throw () -> const char *;
};

GraphFileError::GraphFileError(const std::string & filename, const std::string & message) throw () :
    _what("Error reading graph file '" + filename + "': " + message)
{
}

auto GraphFileError::what() const throw () -> const char *
{
    return _what.c_str();
}

namespace
{
    unsigned long long hacky_global_nodes = 0;

    void load(const std::string & filename, ARGEdit & ed, std::vector<int> & attrs)
    {
        std::ifstream infile{ filename };
        if (! infile)
            throw GraphFileError{ filename, "unable to open file" };

        std::string line;
        while (std::getline(infile, line)) {
            if (line.empty())
                continue;

            /* Lines are comments, a problem description (contains the number of
             * vertices), or an edge. */
            static const boost::regex
                comment{ R"(c(\s.*)?)" },
                problem{ R"(p\s+(edge|col)\s+(\d+)\s+(\d+)?\s*)" },
                label{ R"(l\s+(\d+)\s+(\d+)\s*)" },
                edge{ R"(e\s+(\d+)\s+(\d+)\s*)" };

            boost::smatch match;
            if (regex_match(line, match, comment)) {
                /* Comment, ignore */
            }
            else if (regex_match(line, match, problem)) {
                /* Problem. Specifies the size of the graph. Must happen exactly
                 * once. */
                auto nv = std::stoi(match.str(2));
                attrs.resize(nv);
                for (int i = 0 ; i < nv ; ++i)
                    ed.InsertNode(&attrs[i]);
            }
            else if (regex_match(line, match, edge)) {
                /* An edge. DIMACS files are 1-indexed. We assume we've already had
                 * a problem line (if not our size will be 0, so we'll throw). */
                int a{ std::stoi(match.str(1)) }, b{ std::stoi(match.str(2)) };
                ed.InsertEdge(a - 1, b - 1, NULL);
            }
            else if (regex_match(line, match, label)) {
                int a{ std::stoi(match.str(1)) }, l{ std::stoi(match.str(2)) };
                attrs[a - 1] = l;
            }
            else
                throw GraphFileError{ filename, "cannot parse line '" + line + "'" };
        }

        if (! infile.eof())
            throw GraphFileError{ filename, "error reading file" };
    }

    struct OurComparator : AttrComparator
    {
        virtual bool compatible(void *attr1, void *attr2)
        {
            return *static_cast<int *>(attr1) == *static_cast<int *>(attr2);
        }
    };

    struct CountingVF2MonoState : VF2MonoState
    {
        using VF2MonoState::VF2MonoState;

        virtual void BackTrack() {
            ++hacky_global_nodes;
            VF2MonoState::BackTrack();
        }

        State* Clone()
        { return new CountingVF2MonoState(*this);
        }
    };
}

int main(int argc, char * argv[])
{
    if (argc != 4)
        return EXIT_FAILURE;

    std::ifstream pattern_in(argv[1], std::ios::in | std::ios::binary);
    std::ifstream target_in(argv[2], std::ios::in | std::ios::binary);

    int timeout = atoi(argv[3]);

    ARGEdit pattern_ed, target_ed;
    std::vector<int> pattern_attrs, target_attrs;

    load(argv[1], pattern_ed, pattern_attrs);
    load(argv[2], target_ed, target_attrs);

    int n;
    node_id ni1[8000], ni2[8000];

    std::thread timeout_thread;
    std::mutex timeout_mutex;
    std::condition_variable timeout_cv;

    std::atomic<int> state;
    state.store(0);

    /* Start the clock */
    auto start_time = steady_clock::now();

    timeout_thread = std::thread([&] {
        auto abort_time = steady_clock::now() + std::chrono::seconds(timeout);
        {
            /* Sleep until either we've reached the time limit,
             * or we've finished all the work. */
            std::unique_lock<std::mutex> guard(timeout_mutex);
            while (0 == state.load()) {
                if (std::cv_status::timeout == timeout_cv.wait_until(guard, abort_time)) {
                    /* We've woken up, and it's due to a timeout. */
                    int exp = 0;
                    if (state.compare_exchange_strong(exp, 2)) {
                        auto overall_time = duration_cast<milliseconds>(steady_clock::now() - start_time);
                        std::cout << "aborted" << std::endl;
                        std::cout << std::endl;
                        std::cout << overall_time.count() << std::endl;
                        exit(EXIT_SUCCESS);
                    }
                    break;
                }
            }
        }
    });

    Graph pattern_g(&pattern_ed), target_g(&target_ed);

    pattern_g.SetNodeComparator(new OurComparator);
    target_g.SetNodeComparator(new OurComparator);

    CountingVF2MonoState s0(&pattern_g, &target_g);

    bool result = match(&s0, &n, ni1, ni2);

    auto overall_time = duration_cast<milliseconds>(steady_clock::now() - start_time);

    int exp = 0;
    if (state.compare_exchange_strong(exp, 1)) {
        if (! result) {
            std::cout << "false" << " " << hacky_global_nodes << std::endl;
            std::cout << std::endl;
            std::cout << overall_time.count() << std::endl;
        }
        else {
            std::cout << "true" << " " << hacky_global_nodes << std::endl;
            for (int i = 0 ; i < n ; i++)
                std::cout << "(" << ni1[i] << "=" << ni2[i] << ") ";
            std::cout << std::endl;
            std::cout << overall_time.count() << std::endl;
        }

        /* Clean up the timeout thread */
        if (timeout_thread.joinable()) {
            {
                std::unique_lock<std::mutex> guard(timeout_mutex);
                timeout_cv.notify_all();
            }
            timeout_thread.join();
        }

        return EXIT_SUCCESS;
    }

    return EXIT_FAILURE;
}

