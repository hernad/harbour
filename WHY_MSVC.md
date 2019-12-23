Why Microsoft Visual C++
========================

Microsoft Visual studio is chosen as `primary` compiler for Microsoft Windows platform for this project.

## History

It shoud be noted that I have used [mingw/msys2](https://github.com/hernad/F18/blob/4/ci-build-win32.sh) until now for building Windows versions of our software F18.
Consequently, our actual our Windows harbour builds are also mingw based:
- [harbour-windows-x64](https://bintray.com/bringout/harbour/harbour-windows-x64#files)
- [harbour-windows-x86](https://bintray.com/bringout/harbour/harbour-windows-x86#files)

## Why change?

Recently I have started development with [nodejs/electron](https://github.com/hernad/eShell).
All native nodejs/electron modules for windows are build with MSVC.
After some investigation, I have found that all these large open-source projects build their Windows production versions with `msvc`: 
1. [Libreoffice](https://wiki.documentfoundation.org/Development/BuildingOnWindows)
2. [Openjdk](https://wiki.openjdk.java.net/display/Build/Supported+Build+Platforms)
3. [PostgreSQL](https://www.enterprisedb.com/download-postgresql-binaries)
4. [nodejs](https://docs.microsoft.com/en-us/windows/nodejs/setup-on-windows)

Because, one of the main goals of this project is to make good [bridges to other technology stacks](https://github.com/hernad/harbour/blob/master/README.md#3-solution-make-good-bridges), I have decided to put my efforts toward `msvc`.

## harbour Makefiles and hbmk2 support

I have **NO PLAN**  plan to exclude mingw windows targets. I am just focusing to the msvc because exaplained reason.

## Using Microsoft Visual C++ and software freedom 

Eric Lendvai have sad:

> But I am a little surprised when you mention "software freedom" and you only support MSVC, a non open source compiler under Windows. Mingw (gcc) is open source and quite good under Windows.

The software freedom is mentioned [here](https://github.com/hernad/harbour/blob/master/INFO.txt):

> If somebody share my needs and goals, please fork! Use, test, submit your pull requestes. Forking is base of creativity and software freedom.

I have explained my reasons to `focus` on MSVC, but I should point out much more important thing:

Windows is closed platform. You sould pay to use that. Using their closed source compiler doesn't matters. It is the same thing as using proprietary clang based compiler on Apple/MacOS. The C compilers are commodity today. Nobody make business based on them. They can be considered them as a part of Operating system. Even Microsoft did that move :). Consequently the main thing connected to `software freedom` should be this question:

	Why are you targeting Windows platform?

The answer to that question is: Because my users wants that :).
My strong care about software freedom is the fact that I `myself` creating exclusivelly open-source software.
