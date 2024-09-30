#!/usr/bin/env bash

source ../../make_envars.sh

LIB_NAME=libxml2
LIB_SRC=libxml2
PREFIX=$ROOT_3RD/libxml2

M4DIR=$(pwd)/m4

cd $LIB_SRC

echo "===  lib_src: $LIB_SRC ==== prefix: === $PREFIX ====================="
echo "===  zlib: $ROOT_3RD/zlib/include ==="

#sh ./autogen.sh -f
#    --build=$PREFIX \
#   --with-iconv=$ROOT_3RD/libiconv/include \
#   --with-zlib=$ROOT_3RD/zlib/include
   
rm -f aclocal.m4 
#rm -rf m4
mkdir -p m4
cp -av $M4DIR/* m4/ 
aclocal -I $ACDIR --force && libtoolize --force
automake --add-missing
autoreconf -f


bash  ./configure \
   --without-python \
   --prefix=$PREFIX \
   --with-iconv=$ROOT_3RD/libiconv/include \
   --with-zlib=$ROOT_3RD/zlib/include

make clean install

git checkout -f .
cd ..

