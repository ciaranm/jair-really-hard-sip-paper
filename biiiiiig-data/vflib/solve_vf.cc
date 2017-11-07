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

struct GraphInfo
{
    string name;
    int size;
    vector<int> label;
    vector<vector<int> > adj;
};

auto load(const string & filename, vector<GraphInfo> & graphs, map<string, int> & labels_map) -> bool
{
    ifstream file{ filename };
    if (! file) {
        cerr << "Error opening " << filename << endl;
        return false;
    }

    string name;
    while (file >> name) {
        if (0 != name.compare(0, 1, "#", 0, 1)) {
            cerr << "Bad name '" << name << "'" << endl;
            return false;
        }
        name.erase(0, 1);

        int size;
        file >> size;

        graphs.push_back(GraphInfo{ });
        auto & g = graphs.back();
        g.name = name;
        g.size = size;
        g.label.resize(size);
        g.adj.resize(size, vector<int>(size, 0));

        for (int l = 0 ; l < size ; ++l) {
            string label;
            file >> label;
            if (! labels_map.count(label))
                labels_map.emplace(label, labels_map.size() + 1);

            g.label[l] = labels_map.find(label)->second;
        }

        int edge_count;
        file >> edge_count;
        for (int e = 0 ; e < edge_count ; ++e) {
            int f, t;
            file >> f >> t;
            g.adj[f][t] = g.adj[t][f] = 1;
        }
    }

    cerr << filename << " " << graphs.size() << endl;

    return true;
}

namespace
{
    unsigned long long hacky_global_nodes = 0;

    struct OurComparator : AttrComparator
    {
        virtual bool compatible(void *attr1, void *attr2)
        {
            return *static_cast<int *>(attr1) == *static_cast<int *>(attr2);
        }
    };

    struct TimeForAnAbortion
    {
    };

    struct CountingVF2MonoState : VF2MonoState
    {
        using VF2MonoState::VF2MonoState;

        virtual void BackTrack() {
            if (++hacky_global_nodes > 1000000)
                throw TimeForAnAbortion();

            VF2MonoState::BackTrack();
        }

        State* Clone()
        { return new CountingVF2MonoState(*this);
        }
    };

    void setup(ARGEdit & ed, vector<int> & attrs, const GraphInfo & graph)
    {
        attrs.resize(graph.size);
        for (int i = 0 ; i < graph.size ; ++i) {
            attrs[i] = graph.label[i];
            ed.InsertNode(&attrs[i]);
        }

        for (int i = 0 ; i < graph.size ; ++i)
            for (int j = 0 ; j < graph.size ; ++j)
                if (graph.adj[i][j])
                    ed.InsertEdge(i, j, NULL);
    }
}

int main(int argc, char * argv[])
{
    if (4 != argc) {
        cerr << "Usage: " << argv[0] << " pattern-file target-file sdf" << endl;
        return EXIT_FAILURE;
    }

    map<string, int> labels_map;
    vector<GraphInfo> patterns, targets;
    if (! (load(argv[1], patterns, labels_map) && load(argv[2], targets, labels_map)))
        return EXIT_FAILURE;

    for (const auto & pattern : patterns) {
        for (const auto & target : targets) {
            hacky_global_nodes = 0;
            cout << pattern.name << " -> " << target.name << " " << flush;

            ARGEdit pattern_ed, target_ed;
            std::vector<int> pattern_attrs, target_attrs;

            setup(pattern_ed, pattern_attrs, pattern);
            setup(target_ed, target_attrs, target);

            int n;
            node_id ni1[8000], ni2[8000];

            Graph pattern_g(&pattern_ed), target_g(&target_ed);

            pattern_g.SetNodeComparator(new OurComparator);
            target_g.SetNodeComparator(new OurComparator);

            CountingVF2MonoState s0(&pattern_g, &target_g);

            try {
                bool result = match(&s0, &n, ni1, ni2);

                if (result)
                    cout << hacky_global_nodes << " sat " << endl;
                else
                    cout << hacky_global_nodes << " unsat" << endl;
            }
            catch (const TimeForAnAbortion &) {
                cout << hacky_global_nodes << " fail" << endl;
            }
        }
    }

    return EXIT_SUCCESS;
}

