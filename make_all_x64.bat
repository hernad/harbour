call envars.bat

IF NOT exist tools\win32\Strawberry\perl\bin\perl.exe goto strawberry
:strawberry_end

set BUILD_EXTERNAL=
IF NOT exist 3rd\x64\postgresql\bin\postgres.exe  SET BUILD_EXTERNAL=1

IF DEFINED BUILD_EXTERNAL cd 3rd
IF DEFINED BUILD_EXTERNAL call msvc_x64.bat
IF DEFINED BUILD_EXTERNAL cd ..

IF NOT EXIST 3rd\x86\postgresql\bin\postgres.exe (echo postgresql.exe nije kreiran ? & goto end)

set VCBUILDTOOLS=amd64
set BUILD_ARCH=x64

IF NOT DEFINED HARBOUR_BUILD set INCLUDE=
IF NOT DEFINED HARBOUR_BUILD set LIBPATH=
IF NOT DEFINED HARBOUR_BUILD set PATH=c:\windows;c:\windows\system32

IF NOT DEFINED HARBOUR_BUILD call "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat" %VCBUILDTOOLS%
IF NOT DEFINED HARBOUR_BUILD set PATH=%PATH%;C:\Program Files\Git\cmd
IF NOT DEFINED HARBOUR_BUILD set PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin
IF NOT DEFINED HARBOUR_BUILD set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\%BUILD_ARCH%

REM this contains mingw64
REM IF NOT DEFINED HARBOUR_BUILD set PATH=%PATH%;%PERL_BIN_PATH%

IF NOT DEFINED HARBOUR_BUILD set PATH=%PATH%;%PERL_BIN_PATH%
IF NOT DEFINED HARBOUR_BUILD set PATH=%PATH%;%PERL_SITE_BIN_PATH%

cd %ROOT_DIR%

set HARBOUR_BUILD=1

set LIB_BIN_ROOT=%ROOT_DIR%\3rd\%BUILD_ARCH%
echo Libraries binary root=%LIB_BIN_ROOT%

set HB_INSTALL_PREFIX=%ROOT_DIR%\build\%BUILD_ARCH%\harbour
echo HB_INSTALL_PREFIX=%HB_INSTALL_PREFIX%

set HB_HAS_ZLIB=%LIB_BIN_ROOT%\zlib\include
set HB_HAS_POSTGRESQL=%LIB_BIN_ROOT%\postgresql\include

set HB_WITH_OPENSSL=%LIB_BIN_ROOT%\openssl\include

REM echo lib\win\msvc
REM mkdir lib\win\msvc

tools\win32\win-make.exe clean install

GOTO end

:strawberry
mkdir tools\win32\Strawberry 
cd tools\win32\Strawberry 
..\7z x ..\Strawberry.7z
cd ..\..\..\
goto strawberry_end

:end
echo END ...
