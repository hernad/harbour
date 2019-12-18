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


set LIBRARY=uuid
set ROOT=\users\hernad\harbour
set LIB_TARGET=%ROOT%\3rd\x64\%LIBRARY%


set LIB_SOURCE_DIR=uuid-1.6.2-win32-patched

set HB_INSTALL_PREFIX=%ROOT%\build\x64\harbour


cd %ROOT%\3rd\%LIBRARY%\%LIB_SOURCE_DIR%

nmake -f Makefile.win32

mkdir %ROOT%\3rd\x64
mkdir %LIB_TARGET%
mkdir %LIB_TARGET%\include
mkdir %LIB_TARGET%\lib

copy *.h %LIB_TARGET%\include
copy Release\*.lib %LIB_TARGET%\lib

cd %ROOT%\3rd\%LIBRARY%

dir /s %LIB_TARGET%
