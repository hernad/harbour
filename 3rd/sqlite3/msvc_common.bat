@echo off

IF NOT DEFINED WINSDK_VER set WINSDK_VER=10.0.18362.0
IF NOT DEFINED GIT_REPOS set GIT_REPOS=harbour
set LIBRARY=sqlite3
set LIB_SOURCE_DIR=sqlite-autoconf-3300100

set ROOT_DIR=\Users\%USERNAME%\%GIT_REPOS%
set CMD7z=..\..\tools\win32\7z.exe

set PERL_C_BIN_PATH=%ROOT_DIR%\tools\win32\Strawberry\c\bin
set PERL_BIN_PATH=%ROOT_DIR%\tools\win32\Strawberry\perl\bin
set PERL_SITE_BIN_PATH=%ROOT_DIR%\tools\win32\Strawberry\perl\site\bin

IF NOT DEFINED SQLITE3_BUILD set INCLUDE=
IF NOT DEFINED SQLITE3_BUILD set LIBPATH=
IF NOT DEFINED SQLITE3_BUILD set PATH=c:\windows;c:\windows\system32

IF NOT DEFINED SQLITE3_BUILD call %VCBUILDTOOLS_PATH% %VCBUILDTOOLS%
IF NOT DEFINED SQLITE3_BUILD set PATH=%PATH%;C:\Program Files\Git\cmd
IF NOT DEFINED SQLITE3_BUILD set PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin
IF NOT DEFINED SQLITE3_BUILD set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\%BUILD_ARCH%
REM perl path has to be on the end
IF NOT DEFINED SQLITE3_BUILD SET PATH=%PATH%;%PERL_C_BIN_PATH%
IF NOT DEFINED SQLITE3_BUILD set PATH=%PATH%;%PERL_BIN_PATH%
IF NOT DEFINED SQLITE3_BUILD set PATH=%PATH%;%PERL_SITE_BIN_PATH%
IF NOT DEFINED SQLITE3_BUILD echo %PATH%

set SQLITE3_BUILD=1
REM perl --version
IF NOT ERRORLEVEL 0 GOTO ERROR

set LIB_BIN_ROOT=%ROOT_DIR%\3rd\%BUILD_ARCH%
set LIB_DEST=%LIB_BIN_ROOT%\%LIBRARY%

set HB_INSTALL_PREFIX=%ROOT_DIR%\build\%BUILD_ARCH%\harbour

cd %ROOT_DIR%\3rd\%LIBRARY%


echo ==================================================================

cd %ROOT_DIR%\3rd\%LIBRARY%\%LIB_SOURCE_DIR%

REM ------------------------------------


nmake /f Makefile.msc

cd ..

mkdir %LIB_DEST%
mkdir %LIB_DEST%\bin
mkdir %LIB_DEST%\lib
mkdir %LIB_DEST%\include

REM xcopy /E /I /Y *.* %LIB_DEST%
copy /y sqlite3.h %LIB_DEST%\include
copy /y sqlite3.dll %LIB_DEST%\lib
copy /y sqlite3.exe %LIB_DEST%\bin


git checkout -f
REM ---------------------------------
cd %ROOT_DIR%\3rd\%LIBRARY%

dir /s %LIB_DEST%

:end
echo END

cd %ROOT_DIR%\3rd\%LIBRARY%
