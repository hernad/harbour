#!/bin/bash

source make_envars.sh

make $@


echo HB_INSTALL_PREFIX=$HB_INSTALL_PREFIX
echo ==========================================
echo set PATH with:
echo source make_envars.sh \&\& export PATH=\$HB_INSTALL_PREFIX/bin:\$PATH
