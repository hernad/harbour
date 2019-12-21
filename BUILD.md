# Build harbour

## Windows 

### Prerequsites

- Developer OS: Windows 10 64-bit
- [Visual C++ Build tools 2015](https://go.microsoft.com/fwlink/?LinkId=691126)
- git clone

        git clone hernad/harbour
        REM =>  C:\Users\hernad\harbour
- check WINSDK_VER in `make_envars.bat`


### Windows 32-bit

    make_all_x86.bat
    REM wait ... cca 30-45 min on i7/6core machine

### Windows 64-bit

    make_all_x64.bat


### Windows manual build

    REM setup MS Visual C++ build toolchain (cl.exe, rc.exe)
    REM check WINSDK_VER in `make_envars.bat`

    tools\win32\msvc_x64.bat
    REM => HB_INSTALL_PREFIX=c:\users\%USERNAME%\harbour\build\x64\harbour\bin
    
    REM set harbour path
    SET PATH=%HB_INSTALL_PREFIX%\bin:%PATH%

    REM rebuild hbmk2.exe, install to HB_INSTALL_PREFIX
    make -C utils\hbmk2 clean install
