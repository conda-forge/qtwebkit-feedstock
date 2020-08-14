#!/bin/bash

# Avoid Xcode
if [[ $(uname) == Darwin ]]; then
  PATH=${PREFIX}/bin/xc-avoidance:${PATH}
fi

# Fix bison/m4 error
# https://github.com/conda-forge/bison-feedstock/issues/7
export M4=${BUILD_PREFIX}/bin/m4

if [[ ${HOST} =~ .*linux.* ]]; then
  # Missing g++ workaround.
  ln -s ${GXX} g++ || true
  chmod +x g++
  export PATH=${PWD}:${PATH}
fi

qmake
make -j${CPU_COUNT}
make install
