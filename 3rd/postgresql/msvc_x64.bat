set WINSDK_VER=10.0.18362.0
set GIT_REPOS=harbour
set LIBRARY=postgresql
set LIB_SOURCE_DIR=postgresql-12.1
set VCBUILDTOOLS=amd64
set BUILD_ARCH=x64
set ROOT_DIR=\users\%USERNAME%\%GIT_REPOS%

IF NOT DEFINED POSTGRESQL_BUILD set INCLUDE=
IF NOT DEFINED POSTGRESQL_BUILD set LIBPATH=
IF NOT DEFINED POSTGRESQL_BUILD set PATH=c:\windows;c:\windows\system32

IF NOT DEFINED POSTGRESQL_BUILD call "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat" %VCBUILDTOOLS%
IF NOT DEFINED POSTGRESQL_BUILD  set PATH=%PATH%;C:\Program Files\Git\cmd
IF NOT DEFINED POSTGRESQL_BUILD  set PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin
IF NOT DEFINED POSTGRESQL_BUILD  set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\%BUILD_ARCH%

REM perl path has to be on the end
REM SET PATH=%PATH%;C:\Strawberry\c\bin
IF NOT DEFINED POSTGRESQL_BUILD  SET PATH=%PATH%;C:\Strawberry\perl\bin
IF NOT DEFINED POSTGRESQL_BUILD  SET PATH=%PATH%;C:\Strawberry\perl\site\bin

set POSTGRESQL_BUILD=1


set LIB_BIN_ROOT=%ROOT_DIR%\3rd\%BUILD_ARCH%
set LIB_TARGET=%LIB_BIN_ROOT%\%LIBRARY%

set HB_INSTALL_PREFIX=%ROOT_DIR%\build\%BUILD_ARCH%\harbour

echo === cd %ROOT_DIR%\3rd\%LIBRARY%\%LIB_SOURCE_DIR% ==

cd %ROOT_DIR%\3rd\%LIBRARY%\%LIB_SOURCE_DIR%

REM ------------------------------------

copy /Y ..\config_default.pl %ROOT_DIR%\3rd\%LIBRARY%\%LIB_SOURCE_DIR%\src\tools\msvc\config.pl

call src\tools\msvc\clean.bat

cd src\tools\msvc

perl build.pl
perl install.pl %LIB_TARGET%

cd %LIB_TARGET%

echo copying POSTGRESQL DLL dependencies [%LIB_TARGET%]
copy /y ..\openssl\bin\*.dll bin\
copy /y ..\libxml2\bin\libxml2.dll bin\
copy /y ..\libiconv\lib\libiconv.dll bin\
       

REM ---------------------------------
cd %ROOT_DIR%\3rd\%LIBRARY%

dir /s %LIB_TARGET%
