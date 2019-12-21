call ..\envars.bat
SET ROOT_3RD=%ROOT_DIR%\3rd

set ZLIB_BUILD=
cd %ROOT_3RD%\zlib
call msvc_x64.bat
IF DEFINED DEBUG_BUILD pause

set UUID_BUILD=
cd %ROOT_3RD%\uuid
call msvc_x64.bat
IF DEFINED DEBUG_BUILD pause

set LIBICONV_BUILD=
cd %ROOT_3RD%\libiconv
call msvc_x64.bat
IF DEFINED DEBUG_BUILD pause

set LIBXML2_BUILD=
cd %ROOT_3RD%\libxml2
call msvc_x64.bat
IF DEFINED DEBUG_BUILD pause

set LIBXSLT_BUILD=
REM libxslt depends on libxml2
cd %ROOT_3RD%\libxslt
call msvc_x64.bat
IF DEFINED DEBUG_BUILD pause

set OPENSSL_BUILD=
cd %ROOT_3RD%\openssl
call msvc_x64.bat
IF DEFINED DEBUG_BUILD pause

set POSTGRESQL_BUILD=
cd %ROOT_3RD%\postgresql
call msvc_x64.bat
IF DEFINED DEBUG_BUILD pause

set POSTGRESQL_BUILD=
cd %ROOT_3RD%\curl
call msvc_x64.bat
IF DEFINED DEBUG_BUILD pause
