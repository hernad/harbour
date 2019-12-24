#!/bin/bash

source ../../make_envars.sh

LIB_NAME=openssl
LIB_SRC=OpenSSL_1_1_0l
PREFIX=$ROOT_3RD/$LIB_NAME

cd $LIB_SRC

echo "===  lib_src: $LIB_SRC ==== prefix: === $PREFIX ====================="



#sh ./autogen.sh
perl Configure \
    --prefix=$PREFIX linux-x86_64

make install
cd ..

