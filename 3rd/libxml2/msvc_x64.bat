IF NOT DEFINED WINSDK_VER set WINSDK_VER=10.0.18362.0
IF NOT DEFINED GIT_REPOS set GIT_REPOS=harbour
set LIBRARY=libxml2
set LIB_SOURCE_DIR=libxml2
set VCBUILDTOOLS=amd64
set BUILD_ARCH=x64

REM https://ss64.com/nt/if.html

IF NOT DEFINED LIBXML2_BUILD set INCLUDE=
IF NOT DEFINED LIBXML2_BUILD set LIBPATH=
IF NOT DEFINED LIBXML2_BUILD set PATH=c:\windows;c:\windows\system32

REM amd64 ili x86
IF NOT DEFINED LIBXML2_BUILD call %VCBUILDTOOLS_PATH% %VCBUILDTOOLS%

IF NOT DEFINED LIBXML2_BUILD  SET PATH=%PATH%;C:\users\%USERNAME%\NASM64

IF NOT DEFINED LIBXML2_BUILD  set PATH=%PATH%;C:\Program Files\Git\cmd
IF NOT DEFINED LIBXML2_BUILD  set PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin
IF NOT DEFINED LIBXML2_BUILD  set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\%BUILD_ARCH%

REM perl path has to be on the end
REM SET PATH=%PATH%;%PERL_C_BIN_PATH%
IF NOT DEFINED LIBXML2_BUILD  set PATH=%PATH%;%PERL_BIN_PATH%
IF NOT DEFINED LIBXML2_BUILD  set PATH=%PATH%;%PERL_SITE_BIN_PATH%

set LIBXML2_BUILD=1

set ROOT_DIR=\users\%USERNAME%\%GIT_REPOS%
set LIB_BIN_ROOT=%ROOT_DIR%\3rd\%BUILD_ARCH%
set LIB_TARGET=%LIB_BIN_ROOT%\%LIBRARY%

set HB_INSTALL_PREFIX=%ROOT_DIR%\build\%BUILD_ARCH%\harbour

echo === cd %ROOT_DIR%\3rd\%LIBRARY%\%LIB_SOURCE_DIR% ==

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
