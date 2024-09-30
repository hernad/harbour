#!/usr/bin/env bash

set -o errexit

source ../make_envars.sh
export ZLIB_BUILD=

cd zlib
    ./gcc_x64.sh
cd ..


cd uuid
   ./gcc_x64.sh
cd ..

cd libiconv
  ./gcc_x64.sh
cd ..

unset LIBXML2_BUILD
cd libxml2
  ./gcc_x64.sh
cd ..

unset LIBXSLT_BUILD
cd libxslt
   ./gcc_x64.sh
cd ..

unset OPENSSL_BUILD
cd openssl
  ./gcc_x64.sh
cd ..


unset POSTGRESQL_BUILD
cd postgresql
  ./gcc_x64.sh
cd ..

unset CURL_BUILD
cd curl
 ./gcc_x64.sh
cd ..

unset SQLITE3_BUILD
cd sqlite3
 ./gcc_x64.sh
cd ..

