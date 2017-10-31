BUILD_DIR := intermediate
TARGET_DIR := ./
SUBMAKEFILES := sip.mk

boost_ldlibs := -lboost_regex -lboost_thread -lboost_system -lboost_program_options
gecode_ldlibs := -lgecodeint -lgecodesearch -lgecodekernel -lgecodesupport

override CXXFLAGS += -O3 -march=native -std=c++14 -I./ -W -Wall -g -ggdb3 -pthread
override LDFLAGS += -pthread

