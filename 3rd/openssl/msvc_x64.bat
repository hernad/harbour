set WINSDK_VER=10.0.18362.0
set LIBRARY=openssl
set LIB_SOURCE_DIR=OpenSSL_1_1_0l
REM amd64 ili x86
set VCBUILDTOOLS=amd64

IF NOT DEFINED OPENSSL_BUILD set INCLUDE=
IF NOT DEFINED OPENSSL_BUILD set LIBPATH=
IF NOT DEFINED OPENSSL_BUILD set PATH=c:\windows;c:\windows\system32
IF NOT DEFINED OPENSSL_BUILD call "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat"  %VCBUILDTOOLS%
IF NOT DEFINED OPENSSL_BUILD set PATH=%PATH%;C:\Program Files\Git\cmd
IF NOT DEFINED OPENSSL_BUILD set PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin
IF NOT DEFINED OPENSSL_BUILD set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\x64
IF NOT DEFINED OPENSSL_BUILD SET PATH=%PATH%;%PERL_C_BIN_PATH%
IF NOT DEFINED OPENSSL_BUILD set PATH=%PATH%;%PERL_BIN_PATH%
IF NOT DEFINED OPENSSL_BUILD set PATH=%PATH%;%PERL_SITE_BIN_PATH%
IF NOT DEFINED OPENSSL_BUILD SET PATH=%PATH%;C:\users\%USERNAME%\NASM64
SET OPENSSL_BUILD=1

set ROOT=\users\%USERNAME%\harbour
set LIB_TARGET=%ROOT%\3rd\x64\%LIBRARY%
set HB_INSTALL_PREFIX=%ROOT%\build\x64\harbour

cd %ROOT%\3rd\%LIBRARY%\%LIB_SOURCE_DIR%

call "cpan install Text:Template"

perl Configure --prefix=%LIB_TARGET% --openssldir=%LIB_TARGET% VC-WIN64A
nmake -f makefile install

cd %ROOT%\3rd\%LIBRARY%

dir /s %LIB_TARGET%
