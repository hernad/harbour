#!/usr/bin/env bash

source ../../make_envars.sh

LIB_NAME=libiconv
LIB_SRC=libiconv-1.16
PREFIX=$ROOT_3RD/$LIB_NAME

cd $LIB_SRC

echo "===  lib_src: $LIB_SRC ==== prefix: === $PREFIX ====================="
sh  ./configure --prefix=$PREFIX
make clean install

git checkout -f .
cd ..

