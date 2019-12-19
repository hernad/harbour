set WINSDK_VER=10.0.18362.0
set GIT_REPOS=harbour
set LIBRARY=libxslt
set LIB_SOURCE_DIR=libxslt
set VCBUILDTOOLS=x86
set BUILD_ARCH=x86
set ROOT_DIR=\users\%USERNAME%\%GIT_REPOS%

IF NOT DEFINED LIBXSLT_BUILD set INCLUDE=
IF NOT DEFINED LIBXSLT_BUILD set LIBPATH=
IF NOT DEFINED LIBXSLT_BUILD set PATH=c:\windows;c:\windows\system32
IF NOT DEFINED LIBXSLT_BUILD call "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat" %VCBUILDTOOLS%
IF NOT DEFINED LIBXSLT_BUILD  set PATH=%PATH%;C:\Program Files\Git\cmd
IF NOT DEFINED LIBXSLT_BUILD  set PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin
IF NOT DEFINED LIBXSLT_BUILD  set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\%BUILD_ARCH%

REM perl path has to be on the end
REM SET PATH=%PATH%;C:\Strawberry\c\bin
IF NOT DEFINED LIBXSLT_BUILD  SET PATH=%PATH%;C:\Strawberry\perl\bin
IF NOT DEFINED LIBXSLT_BUILD  SET PATH=%PATH%;C:\Strawberry\perl\site\bin

set LIBXSLT_BUILD=1


set LIB_BIN_ROOT=%ROOT_DIR%\3rd\%BUILD_ARCH%
set LIB_TARGET=%LIB_BIN_ROOT%\%LIBRARY%

set HB_INSTALL_PREFIX=%ROOT_DIR%\build\%BUILD_ARCH%\harbour

cd %ROOT_DIR%\3rd\%LIBRARY%\%LIB_SOURCE_DIR%

REM ------------------------------------

cd win32
cscript configure.js compiler=msvc prefix=%LIB_BIN_ROOT%\%LIBRARY% include=%ROOT_DIR%\3rd\%BUILD_ARCH%\libxml2\include;%ROOT_DIR%\3rd\%BUILD_ARCH%\libiconv\include lib=%ROOT_DIR%\3rd\%BUILD_ARCH%\libxml2\lib;%ROOT_DIR%\3rd\%BUILD_ARCH%\libiconv\lib
nmake -f Makefile.msvc clean install
cd ..

REM ---------------------------------
cd %ROOT_DIR%\3rd\%LIBRARY%

dir /s %LIB_TARGET%
