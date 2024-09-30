#!/usr/bin/env bash

set -o errexit -o pipefail

source make_envars.sh

tools/rhel/git_clean_repos.sh

cd 3rd
./gcc_x64.sh
cd ..

make clean install


echo HB_INSTALL_PREFIX=$HB_INSTALL_PREFIX
echo ==========================================
echo set PATH with:
echo source make_envars.sh \&\& export PATH=\$HB_INSTALL_PREFIX/bin:\$PATH
