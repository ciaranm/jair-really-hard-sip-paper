#include <gecode/int.hh>
#include <gecode/search.hh>

#include <algorithm>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <map>
#include <memory>
#include <numeric>
#include <tuple>
#include <utility>
#include <vector>

using namespace Gecode;

using std::accumulate;
using std::cerr;
using std::cout;
using std::endl;
using std::flush;
using std::iota;
using std::ifstream;
using std::make_tuple;
using std::make_unique;
using std::map;
using std::sort;
using std::string;
using std::tuple;
using std::unique_ptr;
using std::vector;

struct Graph
{
    string name;
    int size;
    vector<int> label;
    vector<vector<int> > adj;
};

auto load(const string & filename, vector<Graph> & graphs, map<string, int> & labels_map) -> bool
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

        graphs.push_back(Graph{ });
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

class SIP : public Space
{
    public:
        IntVarArray mapping;

        SIP(const Graph & pattern, const Graph & target, int maximum_label) :
            mapping(*this, pattern.size, 0, target.size - 1)
        {
            // injectivity
            distinct(*this, mapping);

            // matching labels
            for (int v = 0 ; v < pattern.size ; ++v)
                for (int w = 0 ; w < target.size ; ++w)
                    if (pattern.label[v] != target.label[w])
                        rel(*this, mapping[v], IRT_NQ, w);

            // target edges
            TupleSet target_edges;
            for (int v = 0 ; v < target.size ; ++v)
                for (int w = 0 ; w < target.size ; ++w)
                    if (target.adj[v][w])
                        target_edges.add(IntArgs(2, v, w));
            target_edges.finalize();

            // pattern edges must be mapped to target edges
            for (int v = 0 ; v < pattern.size ; ++v)
                for (int w = v ; w < pattern.size ; ++w)
                    if (pattern.adj[v][w]) {
                        IntVarArray edge(*this, 2);
                        edge[0] = mapping[v];
                        edge[1] = mapping[w];
                        extensional(*this, edge, target_edges);
                    }

            // label-degree
            vector<vector<int> > pattern_label_degrees(pattern.size, vector<int>(maximum_label + 1, 0));
            for (int v = 0 ; v < pattern.size ; ++v)
                for (int w = 0 ; w < pattern.size ; ++w)
                    ++pattern_label_degrees[v][pattern.label[w]];

            vector<vector<int> > target_label_degrees(target.size, vector<int>(maximum_label + 1, 0));
            for (int v = 0 ; v < target.size ; ++v)
                for (int w = 0 ; w < target.size ; ++w)
                    ++target_label_degrees[v][target.label[w]];

            for (int v = 0 ; v < pattern.size ; ++v)
                for (int w = 0 ; w < target.size ; ++w)
                    for (int l = 1 ; l <= maximum_label ; ++l)
                        if (pattern_label_degrees[v][l] > target_label_degrees[w][l])
                            rel(*this, mapping[v], IRT_NQ, w);

            // variable ordering tiebreaking
            vector<int> pattern_degrees(pattern.size), mapping_permutation(pattern.size);
            for (int v = 0 ; v < pattern.size ; ++v)
                pattern_degrees[v] = accumulate(pattern.adj[v].begin(), pattern.adj[v].end(), 0);

            iota(mapping_permutation.begin(), mapping_permutation.end(), 0);

            sort(mapping_permutation.begin(), mapping_permutation.end(), [&] (int a, int b) {
                    return make_tuple(-pattern_degrees[a], a) < make_tuple(-pattern_degrees[b], b);
                    });

            IntVarArray mapping_permuted(*this, pattern.size);
            for (int v = 0 ; v < pattern.size ; ++v)
                mapping_permuted[v] = mapping[mapping_permutation[v]];

            branch(*this, mapping_permuted, INT_VAR_SIZE_MIN(), INT_VAL_MIN());
        }

        SIP(bool share, SIP & s) :
            Space(share, s)
        {
            mapping.update(*this, share, s.mapping);
        }

        virtual Space * copy(bool share)
        {
            return new SIP(share, *this);
        }
};

int main(int argc, char * argv[])
{
    if (3 != argc) {
        cerr << "Usage: " << argv[0] << " pattern-file target-file" << endl;
        return EXIT_FAILURE;
    }

    map<string, int> labels_map;
    vector<Graph> patterns, targets;
    if (! (load(argv[1], patterns, labels_map) && load(argv[2], targets, labels_map)))
        return EXIT_FAILURE;

    for (const auto & pattern : patterns) {
        for (const auto & target : targets) {
            cout << pattern.name << " -> " << target.name << " " << flush;

            DFS<SIP> e(make_unique<SIP>(pattern, target, labels_map.size() + 1).get());
            if (unique_ptr<SIP> s{ e.next() })
                cout << e.statistics().node << " sat " << s->mapping << endl;
            else
                cout << e.statistics().node << " unsat" << endl;
        }
    }

    return EXIT_SUCCESS;
}

