#!/bin/bash

mkdir build
cd build
cmake -G Ninja -D PORT=Qt -D CMAKE_BUILD_TYPE=Release \
    -D USE_LIBHYPHEN=OFF \
    -D CMAKE_INSTALL_PREFIX="${PREFIX}" \
    -D CMAKE_PREFIX_PATH="${PREFIX}" \
    -D MACOS_USE_SYSTEM_ICU=OFF \
    ..

ninja -j $CPU_COUNT
ninja install
