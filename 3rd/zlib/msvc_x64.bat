set PATH=c:\windows;c:\windows\system32
set PATH=%PATH%;C:\Program Files\Git\cmd
set PATH=%PATH%;C:\Users\hernad\AppData\Local\Programs\Microsoft VS Code\bin
set WINSDK_VER=10.0.18362.0
set ZLIB_DIR=zlib-1.2.11
set POSTGRESQL_TARGET=c:\users\hernad\x64\zlib

set HB_INSTALL_PREFIX=c:\users\hernad\harbour-hernad\harbour

REM amd64 ili x86
call "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat" amd64

set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\x64



SET PATH=%PATH%;C:\Strawberry\c\bin
SET PATH=%PATH%;C:\Strawberry\perl\bin
SET PATH=%PATH%;C:\Strawberry\perl\site\bin

SET PATH=%PATH%;C:\users\hernad\NASM64


cd \users\hernad\harbour\3rd\zlib\%ZLIB_DIR%

echo this location should be root location of git repository
echo Setup configure script:

nmake -f win32/Makefile.msc

mkdir c:\users\hernad\x64\zlib
mkdir c:\users\hernad\x64\zlib\include
mkdir c:\users\hernad\x64\zlib\lib

copy *.lib c:\users\hernad\x64\zlib\lib
copy zlib*.dll c:\users\hernad\x64\zlib\lib

copy *.h c:\users\hernad\x64\zlib\include

cd \users\hernad\harbour\3rd\zlib

