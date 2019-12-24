#!/bin/bash

source ../../make_envars.sh

LIB_NAME=postgresql
LIB_SRC=postgresql-12.1
PREFIX=$ROOT_3RD

cd $LIB_SRC

echo "===  lib_src: $LIB_SRC ==== prefix: === $PREFIX ====================="

$ROOT_DIR/tools/rhel/x64/7z.sh x $LIB_SRC.7z


#sh ./autogen.sh
#perl Configure \
#    --prefix=$PREFIX linux-x86_64

#make install
cd ..

