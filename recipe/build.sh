#!/bin/bash

mkdir build
cd build

if [ $(uname) == Darwin ]; then
    # the default values of these require a newer SDK...
    PLATFORM_OPTS="-D MACOS_USE_SYSTEM_ICU=OFF -D USE_UNIX_DOMAIN_SOCKETS=ON -D MACOS_FORCE_SYSTEM_XML_LIBRARIES=OFF"
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
