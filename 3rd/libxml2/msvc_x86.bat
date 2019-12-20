set WINSDK_VER=10.0.18362.0
set GIT_REPOS=harbour
set LIBRARY=libxml2
set LIB_SOURCE_DIR=libxml2
set VCBUILDTOOLS=x86
set BUILD_ARCH=x86
set ROOT_DIR=\users\%USERNAME%\%GIT_REPOS%

IF NOT DEFINED LIBXML2_BUILD set INCLUDE=
IF NOT DEFINED LIBXML2_BUILD set LIBPATH=
IF NOT DEFINED LIBXML2_BUILD set PATH=c:\windows;c:\windows\system32

IF NOT DEFINED LIBXML2_BUILD call "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat" %VCBUILDTOOLS%
IF NOT DEFINED LIBXML2_BUILD  set PATH=%PATH%;C:\Program Files\Git\cmd
IF NOT DEFINED LIBXML2_BUILD  set PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin
IF NOT DEFINED LIBXML2_BUILD  set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\%BUILD_ARCH%

REM perl path has to be on the end
REM SET PATH=%PATH%;%PERL_C_BIN_PATH%
IF NOT DEFINED LIBXML2_BUILD  set PATH=%PATH%;%PERL_BIN_PATH%
IF NOT DEFINED LIBXML2_BUILD  set PATH=%PATH%;%PERL_SITE_BIN_PATH%

set LIBXML2_BUILD=1


set LIB_BIN_ROOT=%ROOT_DIR%\3rd\%BUILD_ARCH%
set LIB_TARGET=%LIB_BIN_ROOT%\%LIBRARY%

set HB_INSTALL_PREFIX=%ROOT_DIR%\build\%BUILD_ARCH%\harbour

cd %ROOT_DIR%\3rd\%LIBRARY%\%LIB_SOURCE_DIR%

REM ------------------------------------

cd win32
cscript configure.js compiler=msvc prefix=%LIB_BIN_ROOT%\%LIBRARY% include=%ROOT_DIR%\3rd\%BUILD_ARCH%\zlib\include;%ROOT_DIR%\3rd\%BUILD_ARCH%\libiconv\include lib=%ROOT_DIR%\3rd\%BUILD_ARCH%\libiconv\lib
nmake -f Makefile.msvc clean install
cd ..

cd include
xcopy /Y /E /I libxml %LIB_TARGET%\include\libxml
RMDIR /Q/S %LIB_BIN_ROOT%\%LIBRARY%\include\libxml2

REM ---------------------------------
cd %ROOT_DIR%\3rd\%LIBRARY%

dir /s %LIB_TARGET%
