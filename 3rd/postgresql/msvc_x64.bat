set PATH=c:\windows;c:\windows\system32
set PATH=%PATH%;C:\Program Files\Git\cmd
set PATH=%PATH%;C:\Users\hernad\AppData\Local\Programs\Microsoft VS Code\bin
set WINSDK_VER=10.0.18362.0
set POSTGRES_DIR=postgresql-12.1

set HB_INSTALL_PREFIX=c:\users\hernad\harbour-hernad\harbour

REM amd64 ili x86
call "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat" amd64

set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\x64



SET PATH=%PATH%;C:\Strawberry\c\bin
SET PATH=%PATH%;C:\Strawberry\perl\bin
SET PATH=%PATH%;C:\Strawberry\perl\site\bin

SET PATH=%PATH%;C:\users\hernad\NASM64


cd \users\hernad\harbour\3rd\postgresql\%POSTGRES_DIR%

echo this location should be root location of git repository
echo Setup configure script:

perl src\tools\msvc\build.pl

perl src\tools\msvc\install.pl c:\users\hernad\x64\libpq client
