#!/bin/bash


source ../../make_envars.sh



LIB_NAME=zlib
LIB_SRC="zlib-1.2.11"
PREFIX=$ROOT_3RD

cd $LIB_SRC

echo "========== $PREFIX ====================="
./configure --prefix=$PREFIX
make clean install
cd ..

#ls $PREFIX
