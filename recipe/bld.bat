@echo on
setlocal EnableDelayedExpansion

where perl.exe
if %ERRORLEVEL% neq 0 (
  echo Could not find perl.exe
  exit /b 1
)

where ruby.exe
if %ERRORLEVEL% neq 0 (
  echo Could not find ruby.exe
  echo "You can get an OS install at https://rubyinstaller.org/"
  exit /b 1
)

REM make sure we can find conda pkg installs:
set "INCLUDE=%LIBRARY_INC%;%INCLUDE%"
set "LIB=%LIBRARY_LIB%;%LIB%"


REM See: https://github.com/annulen/webkit/wiki/Building-QtWebKit-on-Windows
REM      But, use source tarball from Qt Project; projects identical as of 2018-12-14

cd Tools\Scripts

REM Nix downloading pre-built binaries from Russia; use conda pkgs via deps
echo '' > update-qtwebkit-win-libs

REM Not sure why it can't find libwebp; FindWebP.cmake looks like it should work ??
perl.exe build-webkit ^
--qt ^
--release ^
--prefix=%PREFIX% ^
--no-ninja ^
--cmakeargs="-Wno-dev -DCMAKE_PREFIX_PATH=\"%LIBRARY_PREFIX%;%BUILD_PREFIX%\Library;%BUILD_PREFIX%\Library\usr\" -DWEBP_LIBRARIES=\"%LIBRARY_LIB%\libwebp.lib\" -G \"Visual Studio 14 Win64\""

REM Ninja works up until `fatal error LNK1248: image size exceeds maximum allowable size` for JavaScriptCore.lib
REM -G \"Ninja\""

REM Can't add two projects to MSBuild
REM --install needs to come after
