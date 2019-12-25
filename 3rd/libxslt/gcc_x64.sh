#!/bin/bash

source ../../make_envars.sh

LIB_NAME=libxslt
LIB_SRC=libxslt
PREFIX=$ROOT_3RD/$LIB_NAME

cd $LIB_SRC

echo "===  lib_src: $LIB_SRC ==== prefix: === $PREFIX ====================="


#echo LD_LIBRARY_PATH=$LD_LIBRARY_PATH / LDFLAGS=$LDFLAGS


#sh ./autogen.sh

#autoreconf -i

PATH=$ROOT_3RD/libxml2/bin:$ROOT_3RD/libxslt/bin:$PATH

CFLAGS="-I$ROOT_3RD/libxml2/include/libxml2 -I$ROOT_3RD/libxslt/include -I$ROOT_3RD/uuid/include -I$ROOT_3RD/openssl/include"
CFLAGS+=" -I$ROOT_3RD/zlib/include"

CPPFLAGS="$CFLAGS"


./configure \
      CPPFLAGS="$CFLAGS" \
      CFLAGS="$CFLAGS" \
      LDFLAGS="-L $ROOT_3RD/zlib/lib -L$ROOT_3RD/libxml2/lib -L$ROOT_3RD/libxslt/lib -L$ROOT_3RD/uuid/lib -L$ROOT_3RD/openssl/lib" \
    --without-python \
    --prefix=$PREFIX \
    --with-libxml-prefix=$ROOT_3RD/libxml2/bin \
    --with-libxml-include-prefix=$ROOT_3RD/libxml2/include/libxml2 \
    --with-libxml-libs-prefix=$ROOT_3RD/libxml2/lib

#debug
#make SHELL='sh -x'

make LD_LIBRARY_PATH=$ROOT_3RD/libxml2/lib:$LD_LIBRARY_PATH LDFLAGS=-lxml2 install

cd ..

