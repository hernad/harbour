set UUID_BUILD=
set ZLIB_BUILD=
set OPENSSL_BUILD=
set POSTGRESQL_BUILD=

cd zlib
call msvc_x64.bat
cd ..

cd uuid
call msvc_x64.bat
cd ..

cd openssl
call msvc_x64.bat
cd ..

cd postgresql
call msvc_x64.bat
cd ..
