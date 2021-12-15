#!/bin/bash

mkdir build
cd build

if [ $(uname) == Darwin ]; then
    # Use Conda rather than system icu/libxml2 etc (correct?)
    PLATFORM_OPTS="-D MACOS_USE_SYSTEM_ICU=OFF -D MACOS_BUILD_FRAMEWORKS=OFF -D MACOS_FORCE_SYSTEM_XML_LIBRARIES=OFF"
else
    PLATFORM_OPTS=""
fi

cmake -G Ninja -D PORT=Qt -D CMAKE_BUILD_TYPE=Release \
    -D USE_LIBHYPHEN=OFF \
    -D CMAKE_INSTALL_PREFIX="${PREFIX}" \
    -D CMAKE_PREFIX_PATH="${PREFIX}" \
    $PLATFORM_OPTS \
    ..

ninja -j$CPU_COUNT
ninja install
