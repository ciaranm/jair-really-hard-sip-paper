TARGET := solve_subgraph_isomorphism

SOURCES := \
    sequential.cc \
    graph.cc \
    lad.cc \
    dimacs.cc \
    vf.cc \
    solve_subgraph_isomorphism.cc

TGT_LDLIBS := $(boost_ldlibs)

