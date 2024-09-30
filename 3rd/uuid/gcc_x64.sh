#!/usr/bin/env bash


source ../../make_envars.sh

LIB_NAME=uuid
LIB_SRC="uuid-1.6.2"
PREFIX=$ROOT_3RD/$LIB_NAME

cd $LIB_SRC

echo "========== $PREFIX ====================="
./configure --prefix=$PREFIX
make clean
make
make install
cd ..

