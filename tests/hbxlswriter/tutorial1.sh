#!/bin/bash


echo using $HB_INSTALL_PREFIX/lib/libz.so \(libz.so.1\)


[ ! -f libz.so.1 ] && ln -s $HB_INSTALL_PREFIX/lib/libz.so libz.so.1


LD_LIBRARY_PATH=. ./tutorial1

xdg-open tutorial01.xlsx

