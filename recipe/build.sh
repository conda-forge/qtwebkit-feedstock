#!/bin/bash

mkdir build
cd build

echo "arch $ARCH"
if [ $(uname) == Darwin ]; then
    # Use Conda rather than system icu/libxml2 etc (correct?)
    PLATFORM_OPTS="-D MACOS_USE_SYSTEM_ICU=OFF -D MACOS_BUILD_FRAMEWORKS=OFF -D MACOS_FORCE_SYSTEM_XML_LIBRARIES=OFF"
elif [ "$ARCH" == "ppc64le" ]; then
    # JIT not supported
    PLATFORM_OPTS="-D ENABLE_JIT=OFF"
else
    PLATFORM_OPTS=""
fi
echo "PLATFORM_OPTS $PLATFORM_OPTS"

cmake ${CMAKE_ARGS} -G Ninja -D PORT=Qt -D CMAKE_BUILD_TYPE=Release \
    -D USE_LIBHYPHEN=OFF \
    -D CMAKE_INSTALL_PREFIX="${PREFIX}" \
    -D CMAKE_PREFIX_PATH="${PREFIX}" \
    $PLATFORM_OPTS \
    -D CMAKE_CXX_STANDARD=17 \
    ..

ninja -j$CPU_COUNT
ninja install
