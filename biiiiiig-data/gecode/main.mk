BUILD_DIR := intermediate
TARGET_DIR := ./
SUBMAKEFILES := sip.mk

gecode_ldlibs := -lgecodeint -lgecodesearch -lgecodekernel -lgecodesupport

override CXXFLAGS += -O3 -march=native -std=c++14 -I./ -W -Wall -g -ggdb3 -pthread
override LDFLAGS += -pthread

