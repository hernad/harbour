#!/bin/bash

source ../../make_envars.sh

LIB_NAME=libxml2
LIB_SRC=libxml2
PREFIX=$ROOT_3RD

cd $LIB_SRC

echo "===  lib_src: $LIB_SRC ==== prefix: === $PREFIX ====================="
sh ./autogen.sh --prefix=$PREFIX --with-iconv=$ROOT_3RD/include --with-zlib=$ROOT_3RD/include
sh  ./configure --without-python 
#make clean
make
make install DESTDIR=$PREFIX
cd ..

