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

One of the main goals of this project is to make [GOOD BRIDGES to other technology stacks](https://github.com/hernad/harbour/blob/master/README.md#3-solution-make-good-bridges), so I have decided to put my efforts in this project toward `msvc`.

## harbour Makefiles & hbmk2  - minwg support

To be precise, I have **NO PLAN**  plan to exclude mingw windows targets. I am just focusing to the msvc.

## Using Microsoft Visual C++ and software freedom 

There was question on `harbour-users` group:

> But I am a little surprised when you mention "software freedom" and you only support MSVC, a non open source compiler under Windows. Mingw (gcc) is open source and quite good under Windows.

The software freedom is mentioned [here](https://github.com/hernad/harbour/blob/master/INFO.txt):

> If somebody share my needs and goals, please fork! Use, test, submit your pull requestes. Forking is base of creativity and software freedom.

I have explained my reasons to `focus` on MSVC, but for me there are more important things to discuss on the topic:

Windows is closed platform. You sould pay to use that. Using their closed source compiler doesn't matters. If it saves engineering resources to get Windows binaries, it is the best choice.
The same thing as using proprietary clang based compiler on Apple/MacOS. The C compiler is commodity today. Nobody more is trying to make business based on it. So, we can consider them as a part of Operating system. Even Microsoft did that move with providing `msvc` free of charge :). Consequently, the main thing connected to `software freedom` should be this question:

	Why are you targeting Windows platform?

The answer to that question is: Because my users wants that :).

I express the strong care about software freedom with the fact that I `myself` creating exclusivelly open-source software. All of my libraries, tools and end-user applications are open-source software.
