echo lib\win\msvc
mkdir lib\win\msvc

set WINSDK_VER=10.0.18362.0
set GIT_REPOS=harbour
set VCBUILDTOOLS=x86
set BUILD_ARCH=x86
set ROOT_DIR=\users\%USERNAME%\%GIT_REPOS%

IF NOT DEFINED HARBOUR_BUILD set INCLUDE=
IF NOT DEFINED HARBOUR_BUILD set LIBPATH=
IF NOT DEFINED HARBOUR_BUILD set PATH=c:\windows;c:\windows\system32

IF NOT DEFINED HARBOUR_BUILD call "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat" %VCBUILDTOOLS%
IF NOT DEFINED HARBOUR_BUILD set PATH=%PATH%;C:\Program Files\Git\cmd
IF NOT DEFINED HARBOUR_BUILD set PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin
IF NOT DEFINED HARBOUR_BUILD set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\%BUILD_ARCH%

REM this contains mingw64
REM IF NOT DEFINED HARBOUR_BUILD SET PATH=%PATH%;C:\Strawberry\perl\bin

IF NOT DEFINED HARBOUR_BUILD SET PATH=%PATH%;C:\Strawberry\perl\bin
IF NOT DEFINED HARBOUR_BUILD SET PATH=%PATH%;C:\Strawberry\perl\site\bin

cd %ROOT_DIR%

set HARBOUR_BUILD=1

set LIB_BIN_ROOT=%ROOT_DIR%\3rd\%BUILD_ARCH%
echo Libraries binary root=%LIB_BIN_ROOT%

set HB_INSTALL_PREFIX=%ROOT_DIR%\build\%BUILD_ARCH%\harbour
echo HB_INSTALL_PREFIX=%HB_INSTALL_PREFIX%

set HB_HAS_ZLIB=%LIB_BIN_ROOT%\zlib\include
set HB_HAS_POSTGRESQL=%LIB_BIN_ROOT%\postgresql\include

set HB_WITH_OPENSSL=%LIB_BIN_ROOT%\openssl\include

tools\win32\win-make.exe clean install