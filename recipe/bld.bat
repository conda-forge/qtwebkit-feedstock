@echo on
setlocal EnableDelayedExpansion

REM make sure we can find conda pkg installs:
set "INCLUDE=%LIBRARY_INC%;%INCLUDE%"
set "LIB=%LIBRARY_LIB%;%LIB%"


REM See: https://github.com/annulen/webkit/wiki/Building-QtWebKit-on-Windows
REM      But, use source tarball from Qt Project; projects identical as of 2018-12-14

cd Tools\qt

py build-qtwebkit-conan.py ^
--compiler=msvc ^
--qt=%INCLUDE%\qt ^
--install

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
