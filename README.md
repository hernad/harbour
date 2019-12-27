# Binaries

## Linux x64

Download [latest release](https://github.com/hernad/harbour/releases) into ~/Downloads

    export ROOT_DIR=$HOME/ah
    mkdir -p $ROOT_DIR
    cd $ROOT_DIR
    # centos7, fedora30
    tar xvf ~/Downloads/harbour-linux-x64-4.7.1.tar.gz
    # ubuntu
    tar xvf ~/Downloads/harbour-ubuntu-x64-4.7.1.tar.gz

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


# Windows x64

Prerequisites: 
- Microsoft Visual C++ build tools 2015
- Extract windows-x64 binary zip into %ROOT_DIR%\harbour

    set VCBUILDTOOLS_PATH="C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat"    
    set BUILD_ARCH=x64
    set VCBUILDTOOLS=amd64
    set LIB_BIN_ROOT=%ROOT_DIR%\3rd\%BUILD_ARCH%
    set PATH=c:\windows;c:\windows\system32
    set PATH=%PATH%;C:\Program Files\Git\cmd
    set PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin
    set ROOT_DIR=\users\%USERNAME%\ah
    set HB_INSTALL_PREFIX=%ROOT_DIR%\harbour
    call %VCBUILDTOOLS_PATH% %VCBUILDTOOLS%
    set PATH=%HB_INSTALL_PREFIX%\bin;%PATH%
    mkdir %ROOT_DIR%
    cd %ROOT_DIR%
    mkdir %ROOT_DIR%\proj1
    cd %ROOT_DIR%\proj1
    set PROG=? 'Hello world'
    echo %CMD% > hello.prg
    hbmk2 hello.prg -static
    REM We should have our first x64 program saying "Hello world"
    hello.exe
    REM netio management console is here?
    netio --help

# Windows x86

Prerequisites: 
- Microsoft Visual C++ build tools 2015
- Extract windows-x86 binary zip into %ROOT_DIR%\harbour

    set VCBUILDTOOLS_PATH="C:\Program Files (x86)\Microsoft Visual C++ Build Tools\vcbuildtools.bat"    
    set BUILD_ARCH=x86
    set VCBUILDTOOLS=x86
    set LIB_BIN_ROOT=%ROOT_DIR%\3rd\%BUILD_ARCH%
    set PATH=c:\windows;c:\windows\system32
    set PATH=%PATH%;C:\Program Files\Git\cmd
    set PATH=%PATH%;C:\Users\%USERNAME%\AppData\Local\Programs\Microsoft VS Code\bin
    set ROOT_DIR=\users\%USERNAME%\ah
    set HB_INSTALL_PREFIX=%ROOT_DIR%\harbour
    call %VCBUILDTOOLS_PATH% %VCBUILDTOOLS%
    set PATH=%HB_INSTALL_PREFIX%\bin;%PATH%
    mkdir %ROOT_DIR%
    cd %ROOT_DIR%
    mkdir %ROOT_DIR%\proj1
    cd %ROOT_DIR%\proj1
    set PROG=? 'Hello world'
    echo %CMD% > hello.prg
    hbmk2 hello.prg -static
    REM We should have our first x86 program saying "Hello world"
    hello.exe
    REM netio management console is here?
    netio --help

# Source code

## Linux

    git clone https://github.com/hernad/harbour
    cd tests/harupdf
    hbmk2 tharupdf.hbp -static

