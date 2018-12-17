@echo on
setlocal EnableDelayedExpansion

set /A tools_missing=0
where perl.exe
if %ERRORLEVEL% neq 0 (
  echo "Could not find perl.exe (conda's does not work for this build)"
  echo "Recommended install from https://www.activestate.com/products/activeperl/"
  set /A tools_missing=1
)

where ruby.exe
if %ERRORLEVEL% neq 0 (
  echo "Could not find ruby.exe"
  echo "Recommended install from https://rubyinstaller.org/"
  set /A tools_missing=1
)

if %tools_missing% neq 0 (
  exit /b 1
)

REM make sure we can find conda pkg installs:
set "INCLUDE=%LIBRARY_INC%;%INCLUDE%"
set "LIB=%LIBRARY_LIB%;%LIB%"


REM See: https://github.com/annulen/webkit/wiki/Building-QtWebKit-on-Windows
REM      But, use source tarball from Qt Project; projects identical as of 2018-12-14

REM Grab some older gnuwin32 tools for building, specifically for Win QtWebKit
git clone --depth 1 "https://github.com/qt/qt5.git"
set PATH=%cd%\qt5\gnuwin32\bin;%PATH%

cd Tools\Scripts

REM Nix downloading pre-built binaries from Russia; use conda pkgs via deps
echo '' > update-qtwebkit-win-libs

REM Not sure why it can't find libwebp; FindWebP.cmake looks like it should work ??
perl.exe build-webkit ^
--qt ^
--release ^
--prefix=%LIBRARY_PREFIX% ^
--install ^
--cmakeargs="-Wno-dev -DCMAKE_PREFIX_PATH=\"%LIBRARY_PREFIX%;%BUILD_PREFIX%\Library;%BUILD_PREFIX%\Library\usr\" -DWEBP_LIBRARIES=\"%LIBRARY_LIB%\libwebp.lib\" -DSHARED_CORE=OFF -DCMAKE_C_FLAGS_RELEASE=\"/GL-\" -DCMAKE_CXX_FLAGS_RELEASE=\"/GL-\" -DCMAKE_SHARED_LINKER_FLAGS_RELEASE=\"/LTCG-\" -G \"Ninja\""

REM Ninja worked up until `fatal error LNK1248: image size exceeds maximum allowable size` for JavaScriptCore.lib (needed /GL-; see below)
REM Disable 'whole program optimization'
REM https://docs.microsoft.com/en-us/cpp/build/reference/gl-whole-program-optimization?view=vs-2015
REM https://trac.webkit.org/changeset/153464/webkit
REM CMAKE_C_FLAGS_RELEASE="/GL-"
REM CMAKE_CXX_FLAGS_RELEASE="/GL-"
REM CMAKE_MODULE_LINKER_FLAGS_RELEASE="/LTCG-"
REM CMAKE_SHARED_LINKER_FLAGS_RELEASE="/LTCG-"

REM --no-ninja ^
REM Also, can't add two projects to MSBuild
REM --install needs to come after
REM -G \"Visual Studio 14 Win64\"
