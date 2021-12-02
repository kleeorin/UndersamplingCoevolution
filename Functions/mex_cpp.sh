#!/bin/bash
set -eu

MATLABROOT=/Applications/MATLAB_R2019b.app/

CXX=/usr/local/bin/g++-10
CC=/usr/local/bin/gcc-10

CXXFLAGS="-fno-common -arch x86_64 -fexceptions -std=c++11 -fopenmp -Wall -I/usr/local/include"
LDFLAGS="-Wl,-twolevel_namespace -undefined error -arch x86_64 -bundle -Wl,-exported_symbols_list,${MATLABROOT}/extern/lib/maci64/mexFunction.map -L${MATLABROOT}/sys/os/maci64 -L/usr/local/lib -Wl,-rpath,$MATLABROOT/sys/os/maci64:/usr/local/lib -fopenmp"

/Applications/MATLAB_R2019b.app/bin/mex -v \
  CXX=$CXX \
  CXXFLAGS="${CXXFLAGS}" \
  "${1}" \
  LDFLAGS="${LDFLAGS}"
