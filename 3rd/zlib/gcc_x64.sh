#!/bin/bash


source ../../make_envars.sh

LIB_NAME=zlib
LIB_SRC="zlib-1.2.11"
PREFIX=$ROOT_3RD/$LIB_NAME

cd $LIB_SRC

echo "========== $PREFIX ====================="
./configure \
	--prefix=$PREFIX

rm contrib/minizip/*.o
rm contrib/minizip/*.lo

make \
	CFLAGS="-DCREATE_DLL" \
	clean install

git checkout -f .
cd ..

