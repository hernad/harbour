@echo off

IF NOT DEFINED WINSDK_VER set WINSDK_VER=10.0.18362.0
IF NOT DEFINED GIT_REPOS set GIT_REPOS=harbour
set LIBRARY=postgresql
set SOURCE_DIR=postgresql-12.1

set ROOT_DIR=\users\%USERNAME%\%GIT_REPOS%
set CMD7z=..\..\tools\win32\7z.exe

set PERL_C_BIN_PATH=%ROOT_DIR%\tools\win32\Strawberry\c\bin
set PERL_BIN_PATH=%ROOT_DIR%\tools\win32\Strawberry\perl\bin
set PERL_SITE_BIN_PATH=%ROOT_DIR%\tools\win32\Strawberry\perl\site\bin

IF NOT DEFINED POSTGRESQL_BUILD set INCLUDE=
IF NOT DEFINED POSTGRESQL_BUILD set LIBPATH=
IF NOT DEFINED POSTGRESQL_BUILD set PATH=c:\windows;c:\windows\system32
IF NOT DEFINED POSTGRESQL_BUILD call %VCBUILDTOOLS_PATH% %VCBUILDTOOLS%
IF NOT DEFINED POSTGRESQL_BUILD set PATH=%PATH%;C:\Program Files\Git\cmd
IF NOT DEFINED POSTGRESQL_BUILD set PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin
IF NOT DEFINED POSTGRESQL_BUILD set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\%BUILD_ARCH%
REM perl path has to be on the end
IF NOT DEFINED POSTGRESQL_BUILD SET PATH=%PATH%;%PERL_C_BIN_PATH%
IF NOT DEFINED POSTGRESQL_BUILD set PATH=%PATH%;%PERL_BIN_PATH%
IF NOT DEFINED POSTGRESQL_BUILD set PATH=%PATH%;%PERL_SITE_BIN_PATH%

set POSTGRESQL_BUILD=1

REM https://ss64.com/nt/errorlevel.html	
perl --version
IF %ERRORLEVEL% NEQ 0 GOTO ERROR

set LIB_BIN_ROOT=%ROOT_DIR%\3rd\%BUILD_ARCH%
set PSQL_DEST=%LIB_BIN_ROOT%\%LIBRARY%

set HB_INSTALL_PREFIX=%ROOT_DIR%\build\%BUILD_ARCH%\harbour

echo ================ INIT postgresql-12.1 ===========================
cd %ROOT_DIR%\3rd\%LIBRARY%

IF DEFINED SOURCE_DIR rmdir /Q /S %SOURCE_DIR%
%CMD7z% -y x %SOURCE_DIR%.7z
echo ==================================================================

cd %ROOT_DIR%\3rd\%LIBRARY%\%SOURCE_DIR%

REM ------------------------------------

copy /Y ..\config_default.pl %ROOT_DIR%\3rd\%LIBRARY%\%SOURCE_DIR%\src\tools\msvc\config.pl
REM x86 build patch
IF [%BUILD_ARCH%] EQU [x86] copy /Y ..\msvc_build.pl %ROOT_DIR%\3rd\%LIBRARY%\%SOURCE_DIR%\src\tools\msvc\build.pl

cd src\tools\msvc
perl build.pl

REM echo WORKAROUND BUG postgresql-12.1\pgsql.sln.metaproj : error MSB4126: The specified solution configuration Release Win32 is invalid. - run msbuild again
REM cd ..\..\..
REM msbuild pgsql.sln /verbosity:normal /p:Configuration=Release /p:Platform=%POSTGRESQL_BUILD_PLATFORM%

cd src\tools\msvc
perl install.pl %PSQL_DEST%

cd %PSQL_DEST%

echo copying PSQL DLL dependencies %PSQL_DEST%

copy /y ..\openssl\bin\*.dll bin\
copy /y ..\libxml2\bin\libxml2.dll bin\      
copy /y ..\libiconv\lib\libiconv.dll bin\
       

REM ---------------------------------
cd %ROOT_DIR%\3rd\%LIBRARY%

dir /s %PSQL_DEST%

:ERROR
echo ERROR!

:END
echo END
