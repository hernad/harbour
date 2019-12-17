# Build harbour

## Windows 32-bit


    # git clone hernad/harbour =>  C:\Users\hernad\harbour\>
 
    REM PREREQUISITE: Visual Studio Community 2019
    tools\win32\msvc_x86.bat

 
    REM build
    tools\win32\win-make.exe

    REM 
    REM install - HB_INSTALL_PREFIX=c:\Users\hernad\harbour-hernad\harbour
    tools\win32\win-make.exe install


## Windows 64-bit


    # git clone hernad/harbour =>  C:\Users\hernad\harbour\>
 
    REM PREREQUISITE: Visual Studio Community 2019
    tools\win32\msvc_x64.bat

 
    REM build
    tools\win32\win-make.exe

    REM 
    REM install - HB_INSTALL_PREFIX=c:\Users\hernad\harbour-hernad\harbour
    tools\win32\win-make.exe install