# Binaries

## Linux

Download release into ~/Downloads

    export ROOT_DIR=/home/hernad/ah
    mkdir -p $ROOT_DIR
    cd $ROOT_DIR
    tar xvf ~/Downloads/harbour-linux-x64-4.7.1.tar.gz

    export HB_INSTALL_PREFIX=$ROOT_DIR/harbour
    export PATH=$HB_INSTALL_PREFIX/bin:$PATH
    export LD_LIBRARY_PATH=$HB_INSTALL_PREFIX/lib:.
    # TEMP PATCH
    ln -s $HB_INSTALL_PREFIX/lib/libpq.so $HB_INSTALL_PREFIX/lib/libpq.so.5
    # netio management console should be available
    netio --help  # -> should output

    # psql --version # -> should outpt 12.1

    mkdir $ROOT_DIR/proj1
    cd $ROOT_DIR/proj1

    # hello world program 
    echo "? 'Hello World'" > hello.prg

    hbmk2 hello.prg -static
    ./hello # -> should output


# Source code


## Linux

    git clone https://github.com/hernad/harbour
    cd tests/harupdf
    hbmk2 tharupdf.hbp -static

