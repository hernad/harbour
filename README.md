# SIMPLE harbour

## 1. Harbour programming language

### 1.1 Harbour based projects - common scenario 

Harbour programming language is used in production exclusively for business applications (ERP, accounting). Harbour applications are first built with Clipper/DOS (now abandoned programing environment). Projects are built and maintained by dominantly `old school` and also mostly old age :( developers.  

### 1.2 Harbour eco-system

Many developers are relying on commercial tools GUI and reporting libraries (eg. FiveWin, Xailer).
Developers and library vendors mostly targets `win32` platform, minorly `linux`. 
Besises the fact harbour is multiplatform project, mature GUI applications are exclusively built for windos/WinAPI.

### 1.3 Current state

Harbour community is (like most IT communities) enthusiastic about programming language.
The truth is crude:
  - There are NO notable NEW projects built with harbour. 
  - The programming language project is in stalled state. Two lead developers recently abandoned project ([Przemyslaw Czerpak](https://github.com/druzus), [Viktor Szakats](https://github.com/vszakats))
  - Already small community is additionaly fragmented by pratices and vision of future

### 1.4 Future directions

Because of all this facts, let's be realistic.
Community have to explore ways to revive project in directions which can be *achived* in short term with small engineering workforce and *applied* to existing projects! 
So, investing into mobile and web technologies is not a good direction. We don't have enough time and engineering resources (either skills or man's power) to make competitive platform for mobile or web. Because of that we should focus on *standard desktop* and *server* systems. Also, our efforts needs to be directed to projects and applications where harbour still have its competitive value.

### 1.5 Harbour's strengths and weaknesses

#### 1.5.1 business application know-how

Harbour community is old. It is problem. The other side of the coin is this: 

**Most of us have GREAT experience in the area of building and maintaing business applications.** 

We build and maintain in this kind of application **production** for decades. This is HUGE potential unused for the sake of the common project at this moment.

#### 1.5.2 CUI (character user interface) applications

CUI - harbour is great for building data intensive CUI applications. These applications are robust, effective and **supperior** in many use cases over GUI applications. Harbour is top-notch language for building these kind of applications.

#### 1.5.3. built-in xBase Data manipulation

Clipper have raised its popularity with straightforward data manipulation language integrated into language. But there is the *catch*. This syntax is adjusted for separate data tables and not databases. Today, data storage manipulation in business application is dealt by client/server SQL servers. Not file-servers. There are remarkable projects (letodb, netio) which provided the access of DBF tables in client/server regime instead file-server. But, that approach is long-term also "blind path". Why?

1. Because SQL is standard expected by other data users and applications (other systems within organization)

2. More important, harbour community has no resources to develop this **VITAL** part of business applicatin.  Sum all harbour developers and you cannot provide 1/1000 000 of dominant SQL systems (eg PostgreSQL, MySQL, MSSQL)

## 3. Solution: Make GOOD bridges

Let us make good connection with other systems and technologies:
- SQL
- java

HINT: This harbour repository contains PostgreSQL libraries used in production since 2011.

## 4. Goals of this repository

### 4.1 Simple to use

Developer has to have simple workflow:

#### A) from source code

- prerequisite C compiler
- clone harbour repository github
- build compiler
- set binaries PATH 
- start application's development

#### B) from binary code

- prerequisite C compiler
- download actual binaries from github
- set binaries PATH
- start application's development

### 4.2 Simple to develop

#### 4.2.1 Simple repository structure

- 3rd (third party libraries)
  - harupdf
  - minizip
  - pcre2
  - png
  - xlswriter
  - zlib
- utils:
  - hbmk2
  - hbformat
- src: 
  - / compiler, preprocessor, debuger, virtual machine: /
    - common
    - codepage
    - pp
    - main
    - compiler
    - debug
    - lang
    - macro
    - nortl
    - vm
  - / core run-time-libraries (src/rtl) /
      - gtstd
      - gttrm
      - gtwin
      - gtxwt
      - gtxwc
      - gtcgi
      - dbfnsx
      - dbfntx
      - hbsix
      - hsx
      - rddsql
      - rddmisc
      - usrrdd
  - / replacable database drivers (src/rdd): /
      - dbfcdx
      - dbffpt
      - dbfnsx
      - dbfntx
      - hbsix
      - hsx
      - rddsql
      - rddmisc
      - usrrdd
  - / libraries: /
     - hbextern
     - hbct
     - hbhpdf  
     - hbpgsql
     - hbtip
     - hbxlsxwriter
     - hbmzip
     - hbssl 
     - hbwin
     - sddpg

### 4.3 Pragmatic Operating system / compiler support

#### 4.3.1 Primary

- windows (32/64 bit)
   - msvc (Microsoft Visual C/C++)
- linux (64 bit)
   - gcc (GNU Compiler Collection)

#### 4.3.2 Secondary

- MacOS/darwin
   - small interest
   - can be changed if there is *users's* interest
- windows/cygwin
     I suppose this is used by ... nobody, so candidate for removal is nobody 
- linux (32 bit)
   - also "rear animal"

### 4.3.3 NO support

Support for these platforms/compilers is removed (or in the process of removal):
    * Operating systems:
        - DOS
        - android
        - IOS
        - beos
        - various unixes
    * Compilers:
        - mingw
        - borland bcc
        - djgpp
        - watcom


## 5. Why!?

# Q5.1: Why NOT msys2/mingw on windows?

A: The same answer as [libreoffice developers](https://wiki.documentfoundation.org/Development/BuildingOnWindows), section 
  `"Why MSVC?"`

### Q5.2: Why not android/IOS ?

 A: Nobody sane is going to use harbour for mobile development in *production* :)


## 6. References:

 - https://github.com/vszakats/hb
 - https://github.com/harbour/core
 - https://github.com/hernad/harbour-core


