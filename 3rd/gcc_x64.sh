source ../make_envars.sh
export ZLIB_BUILD=

cd zlib
source gcc_x64.sh
cd ..

cd uuid
source gcc_x64.sh
cd ..

cd libiconv
source gcc_x64.sh
cd ..

unset LIBXML2_BUILD
cd libxml2
source gcc_x64.sh
cd ..

unset LIBXSLT_BUILD
cd libxslt
source gcc_x64.sh
cd ..

unset OPENSSL_BUILD
cd openssl
source gcc_x64.sh
cd ..

unset POSTGRESQL_BUILD
cd postgresql
source gcc_x64.sh
cd ..

unset CURL_BUILD
cd curl
source gcc_x64.sh
cd ..

