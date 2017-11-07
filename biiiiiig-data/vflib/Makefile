all : solve_vf

override CXXFLAGS += -O3 -march=native -std=c++14 -I./ -W -Wall -g -ggdb3 -pthread

solve_vf : solve_vf.cc
	$(CXX) $(CXXFLAGS) -o $@ -I vflib-2.0.6/include/ $< -lboost_regex -lboost_thread -lboost_system -lboost_program_options -L vflib-2.0.6/lib/ -lvf
