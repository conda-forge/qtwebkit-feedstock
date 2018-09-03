#!/bin/bash

# Avoid Xcode
if [[ ${HOST} =~ .*darwin.* ]]; then
  PATH=${PREFIX}/bin/xc-avoidance:${PATH}
fi

qmake
make -j${CPU_COUNT}
make install
