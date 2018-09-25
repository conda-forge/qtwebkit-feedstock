#!/bin/bash

# Avoid Xcode
if [[ $(uname) == Darwin ]]; then
  PATH=${PREFIX}/bin/xc-avoidance:${PATH}
fi

# Fix bison/m4 error
# https://github.com/conda-forge/bison-feedstock/issues/7
export M4=${BUILD_PREFIX}/bin/m4

qmake
make -j${CPU_COUNT}
make install
