set WINSDK_VER=10.0.18362.0
set GIT_REPOS=harbour
set LIBRARY=postgresql

set VCBUILDTOOLS=amd64
set BUILD_ARCH=x64
set LIB_SOURCE_DIR=postgresql-12.1


set PATH=c:\windows;c:\windows\system32

REM amd64 ili x86
call "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat" %VCBUILDTOOLS%

SET PATH=%PATH%;C:\Strawberry\c\bin
SET PATH=%PATH%;C:\Strawberry\perl\bin
SET PATH=%PATH%;C:\Strawberry\perl\site\bin
SET PATH=%PATH%;C:\users\%USERNAME%\NASM64

set PATH=%PATH%;C:\Program Files\Git\cmd
set PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin


set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\%BUILD_ARCH%

set ROOT=\users\%USERNAME%\%GIT_REPOS%
set LIB_BIN_ROOT=%ROOT%\3rd\x64
set LIB_TARGET=%LIB_BIN_ROOT%\%LIBRARY%

set HB_INSTALL_PREFIX=%ROOT%\build\x64\harbour


cd %ROOT%\3rd\%LIBRARY%\%LIB_SOURCE_DIR%
REM ------------------------------------

echo podesiti: C:\Users\%USERNAME%\harbour\3rd\postgresql\postgresql-12.1\

copy /Y config_default.pl   %ROOT%\3rd\%LIBRARY%\%LIB_SOURCE_DIR%\src\tools\msvc\config_default.pl

call src\tools\msvc\clean.bat

perl src\tools\msvc\build.pl

perl src\tools\msvc\install.pl %POSTGRESQL_TARGET%


REM ---------------------------------
cd %ROOT%\3rd\%LIBRARY%

dir /s %LIB_TARGET%
