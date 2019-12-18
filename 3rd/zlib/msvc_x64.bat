set PATH=c:\windows;c:\windows\system32

REM amd64 ili x86
call "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat" amd64

SET PATH=%PATH%;C:\Strawberry\c\bin
SET PATH=%PATH%;C:\Strawberry\perl\bin
SET PATH=%PATH%;C:\Strawberry\perl\site\bin
SET PATH=%PATH%;C:\users\hernad\NASM64

set PATH=%PATH%;C:\Program Files\Git\cmd
set PATH=%PATH%;C:\Users\hernad\AppData\Local\Programs\Microsoft VS Code\bin

set WINSDK_VER=10.0.18362.0
set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\x64


set LIBRARY=zlib
set ROOT=\users\hernad\harbour
set LIB_TARGET=%ROOT%\3rd\x64\%LIBRARY%

set LIB_SOURCE_DIR=zlib-1.2.11

set HB_INSTALL_PREFIX=%ROOT%\build\x64\harbour


cd %ROOT%\3rd\%LIBRARY%\%LIB_SOURCE_DIR%

nmake -f win32/Makefile.msc

mkdir %ROOT%\3rd\x64
mkdir %LIB_TARGET%
mkdir %LIB_TARGET%\include
mkdir %LIB_TARGET%\lib

copy *.lib %LIB_TARGET%\lib
copy zlib*.dll %LIB_TARGET%\lib
copy *.h %LIB_TARGET%\include


cd %ROOT%\3rd\%LIBRARY%

dir /s %LIB_TARGET%
