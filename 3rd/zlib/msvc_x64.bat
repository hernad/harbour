set LIBRARY=zlib
set GIT_REPOS=harbour
set WINSDK_VER=10.0.18362.0
set LIB_SOURCE_DIR=zlib-1.2.11
set VCBUILDTOOLS=amd64
set BUILD_ARCH=x64
set ROOT_DIR=\users\%USERNAME%\%GIT_REPOS%

IF NOT DEFINED ZLIB_BUILD set INCLUDE=
IF NOT DEFINED ZLIB_BUILD set LIBPATH=
IF NOT DEFINED ZLIB_BUILD set PATH=c:\windows;c:\windows\system32
IF NOT DEFINED ZLIB_BUILD call "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat" %VCBUILDTOOLS%
IF NOT DEFINED ZLIB_BUILD SET PATH=%PATH%;C:\Strawberry\c\bin
IF NOT DEFINED ZLIB_BUILD SET PATH=%PATH%;C:\Strawberry\perl\bin
IF NOT DEFINED ZLIB_BUILD SET PATH=%PATH%;C:\Strawberry\perl\site\bin
IF NOT DEFINED ZLIB_BUILD set PATH=%PATH%;C:\Program Files\Git\cmd
IF NOT DEFINED ZLIB_BUILD set PATH=%PATH%;C:\Users\hernad\AppData\Local\Programs\Microsoft VS Code\bin
IF NOT DEFINED ZLIB_BUILD set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\%BUILD_ARCH%
set ZLIB_BUILD=1


set LIB_TARGET=%ROOT_DIR%\3rd\%BUILD_ARCH%\%LIBRARY%
set HB_INSTALL_PREFIX=%ROOT_DIR%\build\%BUILD_ARCH%\harbour

cd %ROOT_DIR%\3rd\%LIBRARY%\%LIB_SOURCE_DIR%
del *.obj
nmake -f win32/Makefile.msc

mkdir %ROOT_DIR%\3rd\%BUILD_ARCH%
mkdir %LIB_TARGET%
mkdir %LIB_TARGET%\include
mkdir %LIB_TARGET%\lib

copy *.lib %LIB_TARGET%\lib
copy zlib*.dll %LIB_TARGET%\lib
copy *.h %LIB_TARGET%\include

cd %ROOT_DIR%\3rd\%LIBRARY%

dir /s %LIB_TARGET%
