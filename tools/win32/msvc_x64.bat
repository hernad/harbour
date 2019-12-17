
set PATH=c:\windows;c:\windows\system32
set PATH=%PATH%;C:\Program Files\Git\cmd
set PATH=%PATH%;C:\Users\hernad\AppData\Local\Programs\Microsoft VS Code\bin
set WINSDK_VER=10.0.18362.0



set HB_INSTALL_PREFIX=c:\users\hernad\harbour-hernad\harbour

REM amd64 ili x86
call "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat" amd64

set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\x64


cd \users\hernad\harbour