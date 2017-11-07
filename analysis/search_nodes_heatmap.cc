/* vim: set sw=4 sts=4 et foldmethod=syntax : */

#include <algorithm>
#include <cstdlib>
#include <iostream>
#include <fstream>
#include <string>

#include <boost/format.hpp>

using std::cerr;
using std::cout;
using std::endl;
using std::getline;
using std::ifstream;
using std::max;
using std::stoi;
using std::stoull;
using std::string;
using std::to_string;

using boost::format;
using boost::str;

auto add_results(
        const string & dir, const string & alg,
        int ps, int ts, int pd, int td, int r,
        const string & pd_p, const string & td_p, const string & ed,
        int & failures, unsigned long long & total_nodes) -> bool
{
    string pd_s = (pd_p == "pkr" ? to_string(pd) : str(format("%|1|.%|02|") % (pd / 100) % (pd % 100)));
    string td_s = (td_p == "tkr" ? to_string(td) : str(format("%|1|.%|02|") % (td / 100) % (td % 100)));
    string r_s = str(format("%|02|") % r);

    string filename{dir + "/ps" + to_string(ps) + "-ts" + to_string(ts) + "/" + pd_p + pd_s + "-" + td_p + td_s + "/" + ed + r_s + "." + alg + ".out"};
    ifstream infile{filename};
    if (! infile) {
        cerr << "missing " << filename << endl;
        ++failures;
        return false;
    }

    string success, aborted;
    unsigned long long this_nodes;

    if (string::npos != alg.find("vf3")) {
        infile >> success;
        if (! infile) {
            cerr << "reading " << filename << endl;
            ++failures;
            return false;
        }
        if (success == "aborted")
            aborted = success;
        else
            infile >> this_nodes;
    }
    else if (string::npos != alg.find("vf2")) {
        infile >> success;
        if (success == "aborted")
            aborted = success;
        else
            infile >> this_nodes;

        if (! infile) {
            cerr << "reading " << filename << endl;
            ++failures;
            return false;
        }
    }
    else if (string::npos != alg.find("lad")) {
        string line;
        getline(infile, line);
        if (string::npos == line.find("Run completed") && string::npos == line.find("CPU time exceeded"))
            getline(infile, line);

        if (! infile) {
            cerr << "reading " << filename << endl;
            ++failures;
            return false;
        }

        if (string::npos != line.find("CPU time exceeded"))
            aborted = "aborted";
        else {
            line.erase(0, line.find(';') + 1);
            line.erase(0, line.find(';') + 2);
            line.erase(line.find(' '), line.length());
            this_nodes = stoull(line);
        }
    }
    else if (string::npos != alg.find("clasp")) {
        string line;
        bool found_status = false, found_nodes = false;
        while (getline(infile, line)) {
            if (line.empty())
                continue;

            if ('s' == line.at(0)) {
                found_status = true;
                if (string::npos != line.find("UNKNOWN"))
                    aborted = "aborted";
            }
            else if ('c' == line.at(0) && 0 == line.compare(0, 9, "c Choices", 0, 9)) {
                found_nodes = true;
                line.erase(0, line.find(':') + 1);
                this_nodes = stoull(line);
            }
        }

        if (! (found_status && found_nodes)) {
            cerr << "reading " << filename << endl;
            ++failures;
            return false;
        }
    }
    else if (string::npos != alg.find("glucose")) {
        string line;
        bool found_status = false, found_nodes = false;
        while (getline(infile, line)) {
            if (line.empty())
                continue;

            if ('s' == line.at(0)) {
                found_status = true;
                if (string::npos != line.find("INDETERMINATE"))
                    aborted = "aborted";
            }
            else if ('c' == line.at(0) && 0 == line.compare(0, 9, "c decisions", 0, 9)) {
                found_nodes = true;
                line.erase(0, line.find(':') + 1);
                this_nodes = stoull(line);
            }
        }

        if (! (found_status && found_nodes)) {
            cerr << "reading " << filename << endl;
            ++failures;
            return false;
        }
    }
    else if (string::npos != alg.find("gurobi")) {
        string line;
        bool found_status = false, found_nodes = false;
        while (getline(infile, line)) {
            if (line.empty())
                continue;

            if (0 == line.compare(0, 9, "Model is ", 0, 9)) {
                found_status = true;
            }
            if (0 == line.compare(0, 22, "Optimal solution found", 0, 22)) {
                found_status = true;
            }
            else if (0 == line.compare(0, 18, "Time limit reached", 0, 18)) {
                found_status = true;
                aborted = "aborted";
            }
            else if (0 == line.compare(0, 9, "Explored ", 0, 9)) {
                found_nodes = true;
                line.erase(0, line.find(' ') + 1);
                line.erase(line.find(' ') + 1, line.length());
                this_nodes = stoull(line);
            }
        }

        if (! (found_status && found_nodes)) {
            cerr << "reading " << filename << endl;
            ++failures;
            return false;
        }
    }
    else {
        infile >> success >> this_nodes >> aborted;
        if (! infile) {
            cerr << "reading " << filename << endl;
            ++failures;
            return false;
        }
    }

    if (aborted == "aborted")
        ++failures;
    else
        total_nodes += this_nodes;

    return true;
}

auto main(int argc, char * argv[]) -> int
{
    if (argc != 12) {
        cerr << "Usage: " << argv[0] << " " << "directory extra-directory algorithm pattern_size target_size pattern_prefix target_prefix density_increment repeats pattern_stop target_stop" << endl;
        return EXIT_FAILURE;
    }

    string dir = argv[1];
    string ed = argv[2];
    string alg = argv[3];
    int ps = stoi(argv[4]);
    int ts = stoi(argv[5]);
    string pd_p = argv[6];
    string td_p = argv[7];
    int di = stoi(argv[8]);
    int nr = stoi(argv[9]);
    int px = stoi(argv[10]);
    int tx = stoi(argv[11]);

    unsigned long long max_nodes = 0;

    for (int td = 0 ; td <= tx ; td += di) {
        for (int pd = 0 ; pd <= px ; pd += di) {
            int failures = 0, ns = 0;
            unsigned long long nodes = 0;
            for (int r = 1 ; r <= nr ; ++r)
                if (add_results(dir, alg, ps, ts, pd, td, r, pd_p, td_p, ed, failures, nodes))
                    ++ns;

            if (0 == ns)
                cout << "0 ";
            else if (failures > (nr - ns))
                cout << "fail ";
            else {
                max_nodes = max(nodes, max_nodes);
                cout << (nodes / double(ns)) << " ";
            }
        }
        cout << endl;
    }

    cerr << "max_nodes is " << (max_nodes / double(nr)) << endl;
    return EXIT_SUCCESS;
}

