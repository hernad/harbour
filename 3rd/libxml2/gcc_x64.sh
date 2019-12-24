#!/bin/bash

source ../../make_envars.sh

LIB_NAME=libxml2
LIB_SRC=libxml2
PREFIX=$ROOT_3RD/libxml2

cd $LIB_SRC

echo "===  lib_src: $LIB_SRC ==== prefix: === $PREFIX ====================="
#sh ./autogen.sh
#--build=$PREFIX \
   

sh  ./configure \
   --without-python \
   --prefix=$PREFIX \
   --with-iconv=$ROOT_3RD/libiconv/include \
   --with-zlib=$ROOT_3RD/zlib/include

 
make install

cd ..

