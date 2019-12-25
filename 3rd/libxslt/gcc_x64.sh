#!/bin/bash

source ../../make_envars.sh

LIB_NAME=libxslt
LIB_SRC=libxslt
PREFIX=$ROOT_3RD/$LIB_NAME

cd $LIB_SRC

echo "===  lib_src: $LIB_SRC ==== prefix: === $PREFIX ====================="


#echo LD_LIBRARY_PATH=$LD_LIBRARY_PATH / LDFLAGS=$LDFLAGS


sh ./autogen.sh

autoreconf -i
./configure \
    --without-python \
    --prefix=$PREFIX \
    --with-libxml-prefix=$ROOT_3RD/libxml2/bin \
    --with-libxml-include-prefix=$ROOT_3RD/libxml2/include/libxml2 \
    --with-libxml-libs-prefix=$ROOT_3RD/libxml2/lib

#debug
#make SHELL='sh -x'

make LD_LIBRARY_PATH=$ROOT_3RD/libxml2/lib:$LD_LIBRARY_PATH LDFLAGS=-lxml2 install

cd ..

