@echo off

IF NOT DEFINED WINSDK_VER set WINSDK_VER=10.0.18362.0
IF NOT DEFINED GIT_REPOS set GIT_REPOS=harbour
set LIBRARY=curl
set LIB_SOURCE_DIR=curl-7.67.0

set ROOT_DIR=\Users\%USERNAME%\%GIT_REPOS%
set CMD7z=..\..\tools\win32\7z.exe

set PERL_C_BIN_PATH=%ROOT_DIR%\tools\win32\Strawberry\c\bin
set PERL_BIN_PATH=%ROOT_DIR%\tools\win32\Strawberry\perl\bin
set PERL_SITE_BIN_PATH=%ROOT_DIR%\tools\win32\Strawberry\perl\site\bin

IF NOT DEFINED CURL_BUILD set INCLUDE=
IF NOT DEFINED CURL_BUILD set LIBPATH=
IF NOT DEFINED CURL_BUILD set PATH=c:\windows;c:\windows\system32

IF NOT DEFINED CURL_BUILD call %VCBUILDTOOLS_PATH% %VCBUILDTOOLS%
IF NOT DEFINED CURL_BUILD set PATH=%PATH%;C:\Program Files\Git\cmd
IF NOT DEFINED CURL_BUILD set PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin
IF NOT DEFINED CURL_BUILD set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\%BUILD_ARCH%
REM perl path has to be on the end
IF NOT DEFINED CURL_BUILD SET PATH=%PATH%;%PERL_C_BIN_PATH%
IF NOT DEFINED CURL_BUILD set PATH=%PATH%;%PERL_BIN_PATH%
IF NOT DEFINED CURL_BUILD set PATH=%PATH%;%PERL_SITE_BIN_PATH%
IF NOT DEFINED CURL_BUILD echo %PATH%

set CURL_BUILD=1
perl --version
IF NOT ERRORLEVEL 0 GOTO ERROR

set LIB_BIN_ROOT=%ROOT_DIR%\3rd\%BUILD_ARCH%
set LIB_DEST=%LIB_BIN_ROOT%\%LIBRARY%

set HB_INSTALL_PREFIX=%ROOT_DIR%\build\%BUILD_ARCH%\harbour

cd %ROOT_DIR%\3rd\%LIBRARY%

%CMD7z% -y x  %LIB_SOURCE_DIR%.7z

echo ==================================================================

cd %ROOT_DIR%\3rd\%LIBRARY%\%LIB_SOURCE_DIR%

REM ------------------------------------

REM https://stackoverflow.com/questions/53861300/how-do-you-properly-install-libcurl-for-use-in-visual-studio-2017

cd winbuild
nmake /f Makefile.vc mode=static
cd ..

cd builds\libcurl-vc-%BUILD_ARCH%-release-static-ipv6-sspi-winssl
mkdir %LIB_DEST%
xcopy /E /I /Y *.* %LIB_DEST%

REM ---------------------------------
cd %ROOT_DIR%\3rd\%LIBRARY%

dir /s %LIB_DEST%

:end
echo END

cd %ROOT_DIR%\3rd\%LIBRARY%
