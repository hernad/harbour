#!/bin/bash

source ../../make_envars.sh

LIB_NAME=postgresql
LIB_SRC=postgresql-12.1
PREFIX=$ROOT_3RD

echo "===  lib_src: $LIB_SRC ==== prefix: === $PREFIX ====================="

#[ -n "$ROOT_DIR" ] && rm -rf $ROOT_DIR/3rd/$LIB_NAME/$LIB_SRC

#$ROOT_DIR/tools/rhel/x64/7z.sh x $LIB_SRC.7z

cd $LIB_SRC

#[ ! -d $ROOT_3RD/include/ossp ] && mkdir $ROOT_3RD/include/ossp
#[ -f $ROOT_3RD/include/ossp/uuid.h ] && mv $ROOT_3RD/include/uuid.h $ROOT_3RD/include/ossp/uuid.h
#ln -s $ROOT_3RD/bin/uuid $ROOT_3RD/bin/uuid_export

PATH="$ROOT_3RD/libxml2/bin:$ROOT_3RD/libxslt/bin;$PATH"

## --enable-debug -> config.log

#LD_LIBRARY_PATH="$ROOT_3RD/lib:$LD_LIBRARY_PATH"
#LDFLAGS="-L$ROOT_3RD/lib"

rm config.log

#autoconf -f
sh ./configure \
  CPPFLAGS="-I$ROOT_3RD/libxml2/include/libxml2 -I$ROOT_3RD/libxslt/include -I$ROOT_3RD/uuid/include" \
  CFLAGS="-I$ROOT_3RD/libxml2/include/libxml2 -I$ROOT_3RD/libxslt/include -I$ROOT_3RD/uuid/include" \
  LDFLAGS="-L$ROOT_3RD/libxml2/lib -L$ROOT_3RD/libxslt/lib -L$ROOT_3RD/uuid/lib" \
  --enable-debug \
  --prefix=$ROOT_3RD \
  --with-openssl \
  --with-uuid=ossp \
  --with-libxml \
  --with-libxslt \
  --without-readline

            
#sh ./autogen.sh
#perl Configure \
#    --prefix=$PREFIX linux-x86_64

#make install
cd ..

