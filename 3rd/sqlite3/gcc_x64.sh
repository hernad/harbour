#!/usr/bin/env bash

set -o errexit

source ../../make_envars.sh

LIB_NAME=sqlite3
LIB_SRC=sqlite-autoconf-3300100
PREFIX=$ROOT_3RD/$LIB_NAME

echo "===  lib_src: $LIB_SRC ==== prefix: === $PREFIX ====================="

cd $LIB_SRC

[ -f config.log ] && rm config.log

CFLAGS="-I$ROOT_3RD/libxml2/include/libxml2 -I$ROOT_3RD/libxslt/include -I$ROOT_3RD/uuid/include -I$ROOT_3RD/openssl/include" 
CFLAGS+="-I$ROOT_3RD/zlib/include"

CPPFLAGS="$CFLAGS"

#autoconf -f
#autoreconf -i

#sh ./autogen.sh
rm -f aclocal.m4 

mkdir -p m4
cp -av ../../libxml2/m4/* m4/
cp -av configure.am sqlite-autoconf-3300100/ 

aclocal --force 
#autoconf
libtoolize --force
echo step 5
autoreconf -f
echo step 6
automake --add-missing 


sh ./configure \
  CFLAGS="$CFLAGS" \
  CPPFLAGS="$CPPFLAGS" \
  --prefix=$PREFIX

make clean install

# PATCH: don't change source repos
git checkout -f .

cd ..

