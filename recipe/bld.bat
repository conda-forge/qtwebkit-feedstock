
mkdir build
if errorlevel 1 exit 1
cd build
if errorlevel 1 exit 1

cmake -G Ninja -D PORT=Qt -D CMAKE_BUILD_TYPE=Release ^
    -D USE_LIBHYPHEN=OFF ^
    -D CMAKE_INSTALL_PREFIX="${PREFIX}" ^
    -D CMAKE_PREFIX_PATH="${PREFIX}" ^
    ..
if errorlevel 1 exit 1

ninja -j%CPU_COUNT%
if errorlevel 1 exit 1

ninja install
if errorlevel 1 exit 1
