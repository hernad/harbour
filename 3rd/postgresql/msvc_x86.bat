set WINSDK_VER=10.0.18362.0
set GIT_REPOS=harbour
set LIBRARY=postgresql
set LIB_SOURCE_DIR=postgresql-12.1
set VCBUILDTOOLS=x86
set BUILD_ARCH=x86
set ROOT_DIR=\users\%USERNAME%\%GIT_REPOS%
REM "ORIG c:\Program Files\7-Zip\7z.exe"
set CMD7z=..\..\tools\win32\7z.exe

IF NOT DEFINED POSTGRESQL_BUILD set INCLUDE=
IF NOT DEFINED POSTGRESQL_BUILD set LIBPATH=
IF NOT DEFINED POSTGRESQL_BUILD set PATH=c:\windows;c:\windows\system32

IF NOT DEFINED POSTGRESQL_BUILD call "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat" %VCBUILDTOOLS%
IF NOT DEFINED POSTGRESQL_BUILD set PATH=%PATH%;C:\Program Files\Git\cmd
IF NOT DEFINED POSTGRESQL_BUILD set PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin
IF NOT DEFINED POSTGRESQL_BUILD set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\%BUILD_ARCH%
REM perl path has to be on the end
IF NOT DEFINED POSTGRESQL_BUILD SET PATH=%PATH%;%PERL_C_BIN_PATH%
IF NOT DEFINED POSTGRESQL_BUILD set PATH=%PATH%;%PERL_BIN_PATH%
IF NOT DEFINED POSTGRESQL_BUILD set PATH=%PATH%;%PERL_SITE_BIN_PATH%

set POSTGRESQL_BUILD=1

set LIB_BIN_ROOT=%ROOT_DIR%\3rd\%BUILD_ARCH%
set PSQL_DEST=%LIB_BIN_ROOT%\%LIBRARY%

set HB_INSTALL_PREFIX=%ROOT_DIR%\build\%BUILD_ARCH%\harbour

echo ================ INIT postgresql-12.1 ===========================
cd %ROOT_DIR%\3rd\%LIBRARY%
git clean . -f -d -X
git clean . -f -d -x

%CMD7z% x postgresql-12.1.7z
echo ==================================================================

cd %ROOT_DIR%\3rd\%LIBRARY%\%LIB_SOURCE_DIR%

REM ------------------------------------

copy /Y ..\config_default.pl %ROOT_DIR%\3rd\%LIBRARY%\%LIB_SOURCE_DIR%\src\tools\msvc\config.pl
copy /Y ..\msvc_build.pl %ROOT_DIR%\3rd\%LIBRARY%\%LIB_SOURCE_DIR%\src\tools\msvc\build.pl

cd src\tools\msvc

perl build.pl
perl install.pl %PSQL_DEST%

cd %PSQL_DEST%

echo copying PSQL DLL dependencies %PSQL_DEST%

copy /y ..\openssl\bin\*.dll bin\
copy /y ..\libxml2\bin\libxml2.dll bin\      
copy /y ..\libiconv\lib\libiconv.dll bin\
       

REM ---------------------------------
cd %ROOT_DIR%\3rd\%LIBRARY%

dir /s %PSQL_DEST%
