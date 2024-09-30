#!/usr/bin/env bash

source ../../make_envars.sh

LIB_NAME=curl
LIB_SRC=curl-7.67.0
PREFIX=$ROOT_3RD/$LIB_NAME

echo "===  lib_src: $LIB_SRC ==== prefix: === $PREFIX ====================="

[ -n "$ROOT_DIR" ] && rm -rf $ROOT_DIR/3rd/$LIB_NAME/$LIB_SRC

$ROOT_DIR/tools/rhel/x64/7z.sh x $LIB_SRC.7z

cd $LIB_SRC

#[ ! -d $ROOT_3RD/include/ossp ] && mkdir $ROOT_3RD/include/ossp
#[ -f $ROOT_3RD/include/ossp/uuid.h ] && mv $ROOT_3RD/include/uuid.h $ROOT_3RD/include/ossp/uuid.h
#ln -s $ROOT_3RD/bin/uuid $ROOT_3RD/bin/uuid_export

PATH="$ROOT_3RD/libxml2/bin:$ROOT_3RD/libxslt/bin;$PATH"

## --enable-debug -> config.log

#LD_LIBRARY_PATH="$ROOT_3RD/lib:$LD_LIBRARY_PATH"
#LDFLAGS="-L$ROOT_3RD/lib"

[ -f config.log ] && rm config.log

autoconf -f
CFLAGS="-I$ROOT_3RD/libxml2/include/libxml2 -I$ROOT_3RD/zlib/include  -I$ROOT_3RD/libxslt/include -I$ROOT_3RD/uuid/include -I$ROOT_3RD/openssl/include"

sh ./configure \
  CFLAGS="$CFLAGS" \
  CPPFLAGS="$CFLAGS" \
  LDFLAGS="-L$ROOT_3RD/libxml2/lib -L$ROOT_3RD/zlib/lib  -L$ROOT_3RD/libxslt/lib -L$ROOT_3RD/uuid/lib -L$ROOT_3RD/openssl/lib" \
  --prefix=$PREFIX \
  --with-openssl \
  --with-zlib \
  --without-libssh \
  --without-libssh2

make install
cd ..

