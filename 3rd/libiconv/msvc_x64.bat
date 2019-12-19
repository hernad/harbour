set WINSDK_VER=10.0.18362.0
set GIT_REPOS=harbour
set LIBRARY=libiconv
set LIB_SOURCE_DIR=libiconv-1.16
set VCBUILDTOOLS=amd64
set BUILD_ARCH=x64

REM https://ss64.com/nt/if.html

IF NOT DEFINED LIBICONV_BUILD set INCLUDE=
IF NOT DEFINED LIBICONV_BUILD set LIBPATH=
IF NOT DEFINED LIBICONV_BUILD set PATH=c:\windows;c:\windows\system32

REM amd64 ili x86
IF NOT DEFINED LIBICONV_BUILD call "C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat" %VCBUILDTOOLS%

IF NOT DEFINED LIBICONV_BUILD  SET PATH=%PATH%;C:\users\%USERNAME%\NASM64

IF NOT DEFINED LIBICONV_BUILD  set PATH=%PATH%;C:\Program Files\Git\cmd
IF NOT DEFINED LIBICONV_BUILD  set PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin
IF NOT DEFINED LIBICONV_BUILD  set PATH=%PATH%;C:\Program Files (x86)\Windows Kits\10\bin\%WINSDK_VER%\%BUILD_ARCH%

REM perl path has to be on the end
IF NOT DEFINED LIBICONV_BUILD  SET PATH=%PATH%;C:\Strawberry\c\bin
IF NOT DEFINED LIBICONV_BUILD  SET PATH=%PATH%;C:\Strawberry\perl\bin
IF NOT DEFINED LIBICONV_BUILD  SET PATH=%PATH%;C:\Strawberry\perl\site\bin

set LIBICONV_BUILD=1

set ROOT_DIR=\users\%USERNAME%\%GIT_REPOS%
set LIB_BIN_ROOT=%ROOT_DIR%\3rd\%BUILD_ARCH%
set LIB_TARGET=%LIB_BIN_ROOT%\%LIBRARY%

set HB_INSTALL_PREFIX=%ROOT_DIR%\build\%BUILD_ARCH%\harbour

echo === cd %ROOT_DIR%\3rd\%LIBRARY%\%LIB_SOURCE_DIR% ==

cd %ROOT_DIR%\3rd\%LIBRARY%\%LIB_SOURCE_DIR%

REM ------------------------------------


REM 32-bit: ./configure --host=i686-w64-mingw32 

REM hernad@DESKTOP-A0CN7LS /cygdrive/c/users/hernad/harbour/3rd/libiconv/libiconv-1.16/build-aux
REM $ cp compile ar-lib /usr/local/bin/

/cygdrive/c/users/%USERNAME%/%GIT_REPOS%/3rd/%BUILD_ARCH%/%LIBRARY%

echo windres from C:\Strawberry\c\bin needed
c:\cygwin64\bin\bash.exe  -c "export PATH=/usr/local/bin:/usr/bin:$PATH; cp -av /cygdrive/c/users/%USERNAME%/%GIT_REPOS%/3rd/%LIBRARY%/%LIB_SOURCE_DIR%/build-aux/compile /usr/local/bin"
c:\cygwin64\bin\bash.exe  -c "export PATH=/usr/local/bin:/usr/bin:$PATH; cp -av /cygdrive/c/users/%USERNAME%/%GIT_REPOS%/3rd/%LIBRARY%/%LIB_SOURCE_DIR%/build-aux/ar-ilb /usr/local/bin"

c:\cygwin64\bin\bash.exe  -c "export PATH=/usr/local/bin:/usr/bin:$PATH; ./configure --prefix=/cygdrive/c/users/%USERNAME%/%GIT_REPOS%/3rd/%BUILD_ARCH%/%LIBRARY% --host=x86_64-w64-mingw32 CC=\"compile cl -nologo\" CFLAGS=\"-MD\" CXX=\"compile cl -nologo\" CXXFLAGS=\"-MD\" CPPFLAGS=\"-D_WIN32_WINNT=_WIN32_WINNT_WIN8\" LD=\"link\" NM=\"dumpbin -symbols\" STRIP=\":\" AR=\"ar-lib lib\" RANLIB=\":\""
c:\cygwin64\bin\bash.exe  -c "export PATH=/usr/local/bin:/usr/bin:$PATH; make clean ; make; make install"

REM lib/Makefile
REM libiconv.res.lo : $(srcdir)/../windows/libiconv.rc
REM 	$(LIBTOOL_COMPILE) --tag=RC $(RC) `$(SHELL) $(srcdir)/../windows/windres-options --escape $(PACKAGE_VERSION)` -i $(srcdir)/../windows/libiconv.rc -o libiconv.res.lo --output-format=coff



REM ---------------------------------
cd %ROOT_DIR%\3rd\%LIBRARY%

dir /s %LIB_TARGET%
