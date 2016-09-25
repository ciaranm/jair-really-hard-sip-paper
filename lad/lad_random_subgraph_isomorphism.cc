/* vim: set sw=4 sts=4 et foldmethod=syntax : */

#include <boost/program_options.hpp>

#include <iostream>
#include <exception>
#include <cstdlib>
#include <vector>
#include <random>

namespace po = boost::program_options;

auto create_random_graph(int size, double density, int seed, bool complement, int labels) -> std::pair<std::vector<std::vector<uint8_t>>, std::vector<unsigned> >
{
    std::mt19937 rand;
    rand.seed(seed);
    std::uniform_int_distribution<int> label_dist(0, labels - 1);
    std::uniform_real_distribution<double> dist(0.0, 1.0);

    std::vector<unsigned> result_labels(size, 0);

    if (labels != 0)
        for (int e = 0 ; e < size ; ++e)
            result_labels[e] = label_dist(rand);

    std::vector<std::vector<uint8_t>> result(size, std::vector<uint8_t>(size, 0));

    for (int e = 0 ; e < size ; ++e) {
        for (int f = e + 1 ; f < size ; ++f) {
            if (dist(rand) <= density) {
                result[e][f] = complement ? 0 : 1;
                result[f][e] = complement ? 0 : 1;
            } else {
                result[e][f] = complement ? 1 : 0;
                result[f][e] = complement ? 1 : 0;
            }
        }
    }

    return { result, result_labels };
}

auto var(int a, int b, int target_size) -> int
{
    return a * target_size + b + 1;
}

auto main(int argc, char * argv[]) -> int
{
    try {
        po::options_description display_options{ "Program options" };
        display_options.add_options()
            ("help",                                  "Display help information")
            ;

        po::options_description all_options{ "All options" };
        all_options.add_options()
            ("size",    po::value<int>(),     "Number of vertices")
            ("density", po::value<double>(),  "Density")
            ("labels",  po::value<int>(),     "Number of labels")
            ("seed",    po::value<int>(),     "Seed")
            ("complement",                    "Take the complement")
            ;

        all_options.add(display_options);

        po::positional_options_description positional_options;
        positional_options
            .add("size", 1)
            .add("density", 1)
            .add("labels", 1)
            .add("seed", 1)
            ;

        po::variables_map options_vars;
        po::store(po::command_line_parser(argc, argv)
                .options(all_options)
                .positional(positional_options)
                .run(), options_vars);
        po::notify(options_vars);

        /* --help? Show a message, and exit. */
        if (options_vars.count("help")) {
            std::cout << "Usage: " << argv[0] << " [options] size density labels seed" << std::endl;
            std::cout << std::endl;
            std::cout << display_options << std::endl;
            return EXIT_SUCCESS;
        }

        /* No algorithm or no input file specified? Show a message and exit. */
        if (! options_vars.count("size") || ! options_vars.count("density") || ! options_vars.count("labels") || ! options_vars.count("seed")) {
            std::cout << "Usage: " << argv[0] << " [options] size density labels seed" << std::endl;
            return EXIT_FAILURE;
        }

        int n_labels = options_vars["labels"].as<int>();

        /* Create graphs */
        auto graph = create_random_graph(options_vars["size"].as<int>(), options_vars["density"].as<double>(), options_vars["seed"].as<int>(),
                options_vars.count("complement"), n_labels);

        std::cout << graph.first.size() << std::endl;

        for (unsigned i = 0 ; i < graph.first.size() ; ++i) {
            if (0 != n_labels)
                std::cout << graph.second[i] << " ";

            std::cout << std::count(graph.first.at(i).begin(), graph.first.at(i).end(), 1);
            for (unsigned j = 0 ; j < graph.first.size() ; ++j)
                if (graph.first.at(i).at(j)) {
                    std::cout << " " << j;
                    if (0 != n_labels)
                        std::cout << " 0";
                }

            std::cout << std::endl;
        }

        return EXIT_SUCCESS;
    }
    catch (const po::error & e) {
        std::cerr << "Error: " << e.what() << std::endl;
        std::cerr << "Try " << argv[0] << " --help" << std::endl;
        return EXIT_FAILURE;
    }
    catch (const std::exception & e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return EXIT_FAILURE;
    }
}


