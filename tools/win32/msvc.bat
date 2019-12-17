
REM set ROOT=c:\Users\hernad\x86
REM set PSQL_VER=10.11-1

REM set HB_WITH_PGSQL=%ROOT%\postgresql-%PSQL_VER%\pgsql\include

set PATH=c:\windows;c:\windows\system32
set PATH=%PATH%;C:\Program Files\Git\cmd

REM call "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Visual C++ Build Tools\Windows Desktop Command Prompts\Visual C++ 2015 x86 Native Build Tools Command Prompt.lnk"

REM amd64 ili x86
call "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat" x86

set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\10.0.18362.0\x86


cd \users\hernad\harbour