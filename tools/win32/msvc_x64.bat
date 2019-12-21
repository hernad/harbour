
set PATH=c:\windows;c:\windows\system32
set PATH=%PATH%;C:\Program Files\Git\cmd
set PATH=%PATH%;C:\Users\hernad\AppData\Local\Programs\Microsoft VS Code\bin
set WINSDK_VER=10.0.18362.0
set BUILD_ARCH=x64
set VCBUILDTOOLS=amd64
set ROOT_DIR=\users\%USERNAME%\%GIT_REPOS%


REM set HB_INSTALL_PREFIX=c:\users\hernad\harbour-hernad\harbour
set HB_INSTALL_PREFIX=%ROOT_DIR%\build\%BUILD_ARCH%\harbour

REM amd64 ili x86
call %VCBUILDTOOLS_PATH% %VCBUILDTOOLS%

set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\%BUILD_ARCH%


cd %ROOT_DIR%

echo current dir: %ROOT_DIR%
echo HB_INSTALL_PREFIX=%HB_INSTALL_PREFIX%