#!/usr/bin/env bash

source ../../make_envars.sh

LIB_NAME=postgresql
LIB_SRC=postgresql-12.1
PREFIX=$ROOT_3RD/$LIB_NAME

echo "===  lib_src: $LIB_SRC ==== prefix: === $PREFIX ====================="

[ -n "$ROOT_DIR" ] && rm -rf $ROOT_DIR/3rd/$LIB_NAME/$LIB_SRC

SEVENZ_EXE=7z

if [[ -f $ROOT_DIR/tools/rhel/x64/7z.sh ]] ; then
   SEVENZ_EXE=$ROOT_DIR/tools/rhel/x64/7z.sh
fi

rm -rf ./$LIB_SRC
$SEVENZ_EXE x $LIB_SRC.7z

cd $LIB_SRC

#[ ! -d $ROOT_3RD/include/ossp ] && mkdir $ROOT_3RD/include/ossp
#[ -f $ROOT_3RD/include/ossp/uuid.h ] && mv $ROOT_3RD/include/uuid.h $ROOT_3RD/include/ossp/uuid.h
#ln -s $ROOT_3RD/bin/uuid $ROOT_3RD/bin/uuid_export

PATH=$ROOT_3RD/libxml2/bin:$ROOT_3RD/libxslt/bin:$PATH

## --enable-debug -> config.log

LD_LIBRARY_PATH="$ROOT_3RD/zlib/lib"
LD_LIBRARY_PATH+=":$ROOT_3RD/libxml2/lib"
LD_LIBRARY_PATH+=":$ROOT_3RD/libxslt/lib"
LD_LIBRARY_PATH+=":$ROOT_3RD/openssl/lib"

export LD_LIBRARY_PATH
echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH"

[ -f config.log ] && rm config.log
CFLAGS="-I$ROOT_3RD/libxml2/include/libxml2"
CFLAGS+=" -I$ROOT_3RD/libxslt/include"
CFLAGS+=" -I$ROOT_3RD/uuid/include"
CFLAGS+=" -I$ROOT_3RD/openssl/include"
CFLAGS+=" -I$ROOT_3RD/zlib/include"

CPPFLAGS="$CFLAGS"

echo "CFLAGS=$CFLAGS"

autoconf -f
sh ./configure \
  CPPFLAGS="$CFLAGS" \
  CFLAGS="$CFLAGS" \
  LDFLAGS="-L $ROOT_3RD/zlib/lib -L$ROOT_3RD/libxml2/lib -L$ROOT_3RD/libxslt/lib -L$ROOT_3RD/uuid/lib -L$ROOT_3RD/openssl/lib" \
  --prefix=$PREFIX \
  --with-openssl \
  --with-uuid=ossp \
  --with-libxml \
  --with-libxslt \
  --with-zlib \
  --without-readline

make install
cd ..

