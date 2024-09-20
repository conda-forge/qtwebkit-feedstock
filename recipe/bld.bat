
mkdir build
if errorlevel 1 exit 1
cd build
if errorlevel 1 exit 1

cmake %CMAKE_ARGS% ^
    -G Ninja ^
    -D PORT=Qt ^
    -D USE_LIBHYPHEN=OFF ^
    -D CMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -D CMAKE_CXX_STANDARD=17 ^
    ..
if errorlevel 1 exit 1

ninja -j%CPU_COUNT%
if errorlevel 1 exit 1

ninja install
if errorlevel 1 exit 1
