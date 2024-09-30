#!/usr/bin/env bash

set -o errexit

source ../../make_envars.sh

LIB_NAME=zlib
LIB_SRC="zlib-1.2.11"
PREFIX=$ROOT_3RD/$LIB_NAME

cd $LIB_SRC

echo "========== $PREFIX ====================="
./configure \
	--prefix=$PREFIX

rm -rf contrib/minizip/*.o
rm -rf contrib/minizip/*.lo

make \
	CFLAGS="-DCREATE_DLL" \
	clean install

git checkout -f .
cd ..

