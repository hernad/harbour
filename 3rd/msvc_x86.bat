set ZLIB_BUILD=
cd zlib
call msvc_x86.bat
cd ..
IF DEFINED DEBUG_BUILD pause

set UUID_BUILD=
cd uuid
call msvc_x86.bat
cd ..
IF DEFINED DEBUG_BUILD pause

set LIBICONV_BUILD=
cd libiconv
call msvc_x86.bat
cd ..
IF DEFINED DEBUG_BUILD pause

set LIBXML2_BUILD=
cd libxml2
call msvc_x86.bat
cd ..
IF DEFINED DEBUG_BUILD pause

set LIBXSLT_BUILD=
REM libxslt depends on libxml2
cd libxslt
call msvc_x86.bat
cd ..
IF DEFINED DEBUG_BUILD pause

set OPENSSL_BUILD=
cd openssl
call msvc_x86.bat
cd ..
IF DEFINED DEBUG_BUILD pause

set POSTGRESQL_BUILD=
cd postgresql
call msvc_x86.bat
cd ..
IF DEFINED DEBUG_BUILD pause
