/*
 * Copyright 2003-2007 Przemyslaw Czerpak <druzus@priv.onet.pl>
 *   - gcc and *nix configuration elements
 *   - bash script with similar purpose for gcc family
 *   - entry point override method and detection code for gcc
 *   - RTLink/Blinker/ExoSpace link script parsers
 *   - original POTMerge(), LoadPOTFilesAsHash(), GenHBL() and AutoTrans()
 *   - optimized header time scan algorithm
 *   - shell core runner logic
 *
 * See above for licensing terms.
 *
 */

/* Keeping it tidy */
#pragma -w2
#pragma -es2

/* Optimizations */
#pragma -km+
#pragma -ko+

/*
Compatibility flags: -k[options]

Options:  c               clear all flags (strict Clipper mode)
          h[-]            Harbour mode (default)
          o[-]            allow operator optimizations
          i[-]            enable support for HB_INLINE (default)
          r[-]            runtime settings enabled
          s[-]            allow indexed assignment on all types
          x[-]            extended Xbase++ mode (default)
          u[-]            strings in user encoding
          d[-]            accept macros with declared symbols
          m[+]            turn off macrotext substitution
          j[+]            turn off jump optimization in pcode
          ?               this info
*/

#include "directry.ch"
#include "error.ch"
#include "fileio.ch"
#include "set.ch" /* needed for -u */
#include "simpleio.ch" /* Do not delete this, it is useful for development. */

#include "hbgtinfo.ch"
#include "hbhrb.ch"
#include "hbver.ch"

#include "hbextcdp.ch"
#include "hbextlng.ch"


/* For -u support we use 'WHILE' instead of 'DO WHILE',
   'EXTERNAL' instead of 'REQUEST'
   'END' instead of 'END SEQUENCE' 
 */

ANNOUNCE HB_GTSYS
EXTERNAL HB_GT_CGI_DEFAULT
#define _HBMK_GT_DEF_ "GTCGI"


/* Include these for -pause support. */

#if defined( __PLATFORM__WINDOWS )
   EXTERNAL HB_GT_WIN
   EXTERNAL HB_GT_WVT
#elif defined( __PLATFORM__UNIX )
   EXTERNAL HB_GT_TRM
   #if defined( HBMK_WITH_GTXWC )
      EXTERNAL HB_GT_XWC
   #endif
#endif


EXTERNAL hbmk_KEYW

/* needed for -u */
#ifndef HB_SYMBOL_UNUSED
#define HB_SYMBOL_UNUSED( symbol )  ( ( symbol ) )
#endif

#xtranslate _HBMK_STRINGIFY( <x> ) => <"x">

#define _SELF_NAME_             "hbmk2"
#define _SELF_NAME_LONG_        "Harbour Make"


#define I_( x )                 hb_UTF8ToStr( hb_i18n_gettext( x /*, _SELF_NAME_ */ ) )

#define H_( x )                 I_( x )
#define S_( x )                 "^"
#define R_( x )                 ( x )  /* marking for regexps */

#define _TARG_PLAT              1
#define _TARG_COMP              2
#define _TARG_CPU               3

#define _PAR_NEW( cParam, cFileName, nLine ) { cParam, cFileName, nLine }
#define _PAR_cParam             1
#define _PAR_cFileName          2
#define _PAR_nLine              3

#define _WARN_DEF               0  /* Do not set any explicit warning level */
#define _WARN_MAX               1
#define _WARN_YES               2  /* Default level in Harbour build */
#define _WARN_LOW               3  /* Low level, used for 3rd party code in Harbour build */
#define _WARN_NO                4  /* Explicitly disable warnings */

#define _COMPR_OFF              0
#define _COMPR_DEF              1
#define _COMPR_MIN              2
#define _COMPR_HIGH             3
#define _COMPR_MAX              4

#define _HEAD_OFF               0
#define _HEAD_FULL              1
#define _HEAD_NATIVE            2
#define _HEAD_DEP               3

#define _COMPDET_bBlock         1
#define _COMPDET_cCOMP          2
#define _COMPDET_cCCPREFIX      3  /* optional */
#define _COMPDET_cCCSUFFIX      4  /* optional */
#define _COMPDET_cPLAT          5  /* optional */

#define _COMPDETE_bBlock        1
#define _COMPDETE_cPLAT         2
#define _COMPDETE_cCOMP         3
#define _COMPDETE_cCCPREFIX     4
#define _COMPDETE_cCCPATH       5
#define _COMPDETE_bSetup        6

#define _HBMODE_NATIVE          (  0xFFFFFF )
#define _HBMODE_HB10            (  0x010000 )
#define _HBMODE_HB20            (  0x020000 )
#define _HBMODE_HB30            (  0x030000 )
#define _HBMODE_HB32            (  0x030200 )
#define _HBMODE_XHB             ( -0x010200 )
#define _HBMODE_RAW_C           ( -1 )

#define _HBMODE_IS_HB( n )      ( n >= _HBMODE_HB10 )
#define _HBMODE_IS_HB_O( n, r ) ( n >= _HBMODE_HB10 .AND. n <= r )
#define _HBMODE_IS_OLDHB( n )   ( n >= _HBMODE_HB10 .AND. n < _HBMODE_NATIVE )

#define HB_HAS_OPTION( str )    ( " " + ( str ) + " " $ " " + hb_Version( HB_VERSION_OPTIONS ) + " " )

#define _CONF_RELEASE           0  /* No debug */
#define _CONF_DEBUG             1  /* Harbour level debug */
#define _CONF_FULLDEBUG         2  /* Harbour + C level debug */

#define _ESC_NONE               0
#define _ESC_DBLQUOTE           1
#define _ESC_SGLQUOTE_WATCOM    2
#define _ESC_NIX                3

#define _FNF_BCKSLASH           0
#define _FNF_FWDSLASH           1
#define _FNF_FWDSLASHCYGWIN     2
#define _FNF_FWDSLASHMSYS       3

#define _MACRO_NORM_PREFIX      "$"
#define _MACRO_LATE_PREFIX      "%"
#define _MACRO_PREFIX_ALL       ( _MACRO_NORM_PREFIX + _MACRO_LATE_PREFIX )
#define _MACRO_OPEN             "{"
#define _MACRO_CLOSE            "}"

#define _CMDSUBST_OPEN          "`"
#define _CMDSUBST_CLOSE         _CMDSUBST_OPEN

#define _LNG_MARKER             ( _MACRO_LATE_PREFIX + _MACRO_OPEN + "hb_lng" + _MACRO_CLOSE )

#define _HBMK_ENV_INSTALL_PFX   "HB_INSTALL_PREFIX"
#define _HBMK_ENV_NAME          "HBMK_OPTIONS"
#define _HBMK_AUTOHBC_NAME      "hbmk.hbc"
#define _HBMK_AUTOHBM_NAME      "hbmk.hbm"

#define _HBMK_SPECDIR_CONTRIB   "contrib"
#define _HBMK_SPECDIR_ADDONS    "addons"
#define _HBMK_SPECDIR_DOC       "doc"

/* This default value supports both RFC3161 and MS Authenticode. */
/* Review condition at [BOOKMARK:1] if you change this value. */
#define _HBMK_SIGN_TIMEURL_DEF  "http://timestamp.digicert.com"

#define _HBMK_HBEXTREQ          "__HBEXTREQ__"
#define _HBMK_WITH_TPL          "HBMK_WITH_%1$s"
#define _HBMK_HAS_TPL           "HBMK_HAS_%1$s"
#define _HBMK_HAS_TPL_LOCAL     "HBMK_HAS_%1$s_LOCAL"
#define _HBMK_HAS_TPL_HBC       "HBMK_HAS_%1$s"
#define _HBMK_DIR_TPL           "HBMK_DIR_%1$s"
#define _HBMK_PLUGIN            "__HBSCRIPT__HBMK_PLUGIN"
#define _HBMK_SHELL             "__HBSCRIPT__HBSHELL"

#define _HBMK_IMPLIB_EXE_SUFF   "_exe"
#define _HBMK_IMPLIB_DLL_SUFFH  "_dll"  /* Harbour convention (there is no general convention for this) */
#define _HBMK_IMPLIB_DLL_SUFFG  ".dll"  /* GNU (Cygwin/MinGW) convention */

#define _HBMK_TARGENAME_ADHOC   ".adhoc."

#define _HBMK_REGEX_INCLUDE     R_( '(?:^|;)[ \t]*#[ \t]*(?:incl|inclu|includ|include|import)[ \t]*(\".+?\"' + "|<.+?>|['`].+?')" )
#define _HBMK_REGEX_REQUIRE     R_( '(?:^|;)[ \t]*#[ \t]*require[ \t]*(\".+?\"' + "|'.+?')" )
#define _HBMK_REGEX_SETPROC     R_( '(?:^|;)[ \t]*SET[ \t]+(?:PROC|PROCE|PROCED|PROCEDU|PROCEDUR|PROCEDURE)[ \t]+TO[ \t]+(\".+?\"' + "|'.+?'|\S+)" )

#define _HBMK_NEST_MAX          10
#define _HBMK_HEAD_NEST_MAX     10

#define _VAR_MODE_SET           1
#define _VAR_MODE_APPEND        2
#define _VAR_MODE_INSERT        3
#define _VAR_MODE_DELETE        4

#if defined( __PLATFORM__WINDOWS )
   #define _OSCONFDIR_ENV_         "APPDATA"
#else
   #define _OSCONFDIR_ENV_         "HOME"
#endif

#define _CONFDIR_UNIX_             "harbour"
#define _CONFDIR_BASE_          ".harbour"
#define _WORKDIR_BASE_          ".hbmk"

#define _WORKDIR_DEF_           ( _WORKDIR_BASE_ + hb_ps() + hbmk[ _HBMK_cPLAT ] + hb_ps() + hbmk[ _HBMK_cCOMP ] )

#define HB_ISALPHA( c )         hb_asciiIsAlpha( c )
#define HB_ISFIRSTIDCHAR( c )   ( HB_ISALPHA( c ) .OR. ( c ) == "_" )
#define HB_ISNEXTIDCHAR( c )    ( HB_ISFIRSTIDCHAR( c ) .OR. hb_asciiIsDigit( c ) )

#define hb_RightEq( s, c )      ( Right( s, Len( c ) ) == c )
#define hb_RightEqI( s, c )     hb_RightEq( Lower( s ), Lower( c ) )

/* Logic (hack) to automatically add some libs to their
   right place in the liblist. In case of 'unicows' lib,
   this should be after all app lib and before any Windows
   system libs. [vszakats] */
#define _IS_AUTOLIBSYSPRE( c )  ( hbmk[ _HBMK_cPLAT ] == "win" .AND. Lower( hb_FNameName( c ) ) == "unicows" )

#define _OUT_EOL                hb_eol()   /* used when displaying text */
#define _FIL_EOL                Chr( 10 )  /* used when creating source files */

#ifdef HB_LEGACY_LEVEL4
   #define _HBMK_PLUGIN_APIVER  2
#else
   #define _HBMK_PLUGIN_APIVER  3
#endif

#define _HBMK_IMPLIB_NOTFOUND   -1
#define _HBMK_IMPLIB_OK         0
#define _HBMK_IMPLIB_FAILED     1
#define _HBMK_IMPLIB_COPYFAIL   2

#define _CCOMP_PASS_C           1
#define _CCOMP_PASS_CPP         2

#define _HBMK_lQuiet            1
#define _HBMK_lInfo             2
#define _HBMK_nMaxCol           3
#define _HBMK_cPLAT             4
#define _HBMK_cCOMP             5
#define _HBMK_cCPU              6
#define _HBMK_cBUILD            7
#define _HBMK_cGTDEFAULT        8
#define _HBMK_aLIBCOREGT        9
#define _HBMK_aLIBCOREGTDEF     10
#define _HBMK_cGT               11

#define _HBMK_cHB_INSTALL_PFX   12
#define _HBMK_cHB_INSTALL_BIN   13
#define _HBMK_cHB_INSTALL_LIB   14
#define _HBMK_cHB_INSTALL_LI3   15
#define _HBMK_cHB_INSTALL_DYN   16
#define _HBMK_cHB_INSTALL_INC   17
#define _HBMK_cHB_INSTALL_ADD   18
#define _HBMK_cHB_INSTALL_CON   19
#define _HBMK_cHB_INSTALL_DOC   20

#define _HBMK_lGUI              21
#define _HBMK_lMT               22
#define _HBMK_lPIC              23
#define _HBMK_lDEBUG            24
#define _HBMK_nHEAD             25
#define _HBMK_aINCPATH          26
#define _HBMK_lREBUILD          27
#define _HBMK_lCLEAN            28
#define _HBMK_lTRACE            29
#define _HBMK_lDONTEXEC         30
#define _HBMK_nHBMODE           31
#define _HBMK_cUILNG            32
#define _HBMK_aLIBUSER          33
#define _HBMK_aLIBUSERFWK       34
#define _HBMK_aLIBUSERGT        35
#define _HBMK_aLIBUSERSYS       36
#define _HBMK_aLIBUSERSYSPRE    37
#define _HBMK_aLIBFILTEROUT     38
#define _HBMK_aLIBPATH          39
#define _HBMK_aINSTPATH         40
#define _HBMK_aOPTC             41
#define _HBMK_aOPTCUSER         42
#define _HBMK_aOPTCX            43
#define _HBMK_aOPTCPPX          44
#define _HBMK_aOPTPRG           45
#define _HBMK_aOPTRES           46
#define _HBMK_aOPTL             47
#define _HBMK_aOPTLPOST         48
#define _HBMK_aOPTA             49
#define _HBMK_aOPTD             50
#define _HBMK_aOPTDPOST         51
#define _HBMK_aOPTI             52
#define _HBMK_aOPTS             53
#define _HBMK_lCPP              54
#define _HBMK_lSHARED           55
#define _HBMK_lSTATICFULL       56
#define _HBMK_lSHAREDDIST       57
#define _HBMK_lNULRDD           58
#define _HBMK_lMAP              59
#define _HBMK_lBEEP             60
#define _HBMK_lSTRIP            61
#define _HBMK_lOPTIM            62
#define _HBMK_nCOMPR            63
#define _HBMK_nWARN             64
#define _HBMK_lHARDEN           65
#define _HBMK_lRUN              66
#define _HBMK_lINC              67
#define _HBMK_lREBUILDPO        68
#define _HBMK_lMINIPO           69
#define _HBMK_lWINUNI           70
#define _HBMK_nCONF             71
#define _HBMK_lIGNOREERROR      72
#define _HBMK_lIMPLIB           73
#define _HBMK_lHBCPPMM          74
#define _HBMK_hDEP              75

#define _HBMK_lCreateLib        76
#define _HBMK_lCreateDyn        77
#define _HBMK_lCreateImpLib     78
#define _HBMK_lCreatePPO        79
#define _HBMK_lCreateHRB        80

#define _HBMK_lDynVM            81

#define _HBMK_lBLDFLGP          82
#define _HBMK_lBLDFLGC          83
#define _HBMK_lBLDFLGL          84

#define _HBMK_cFIRST            85
#define _HBMK_aPRG              86
#define _HBMK_aCH               87
#define _HBMK_aC                88
#define _HBMK_aCPP              89
#define _HBMK_aRESSRC           90
#define _HBMK_aRESCMP           91
#define _HBMK_aOBJUSER          92
#define _HBMK_aICON             93
#define _HBMK_cMANIFEST         94
#define _HBMK_aIMPLIBSRC        95
#define _HBMK_aDEF              96
#define _HBMK_aINSTFILE         97
#define _HBMK_hDEPTS            98
#define _HBMK_aREQUEST          99

#define _HBMK_aPO               100
#define _HBMK_cHBL              101
#define _HBMK_cHBLDir           102
#define _HBMK_aLNG              103
#define _HBMK_cPO               104

#define _HBMK_hPLUGINHRB        105
#define _HBMK_hPLUGINVars       106
#define _HBMK_aPLUGINPars       107
#define _HBMK_hPLUGINExt        108

#define _HBMK_lDEBUGTIME        109
#define _HBMK_lDEBUGINC         110
#define _HBMK_lDEBUGSTUB        111
#define _HBMK_lDEBUGI18N        112
#define _HBMK_lDEBUGDEPD        113
#define _HBMK_lDEBUGPARS        114
#define _HBMK_lDEBUGCMDL        115

#define _HBMK_cCCPATH           116
#define _HBMK_cCCPREFIX         117
#define _HBMK_cCCSUFFIX         118
#define _HBMK_cCCEXT            119

#define _HBMK_cWorkDir          120
#define _HBMK_cWorkDirDynSub    121
#define _HBMK_nCmd_Esc          122
#define _HBMK_nScr_Esc          123
#define _HBMK_nCmd_FNF          124
#define _HBMK_nScr_FNF          125
#define _HBMK_nExitCode         126

#define _HBMK_cPROGDIR          127
#define _HBMK_cPROGNAME         128

#define _HBMK_hAUTOHBC          129  /* trigger header => .hbc associations */
#define _HBMK_hAUTOHBCFOUND     130  /* trigger headers found */

#define _HBMK_aDEPTHBC          131  /* .hbc references found */
#define _HBMK_hDEPTSDIR         132  /* Header dirs found for dependencies */

#define _HBMK_lStopAfterInit    133
#define _HBMK_lStopAfterHarbour 134

#define _HBMK_cCOMPVer          135
#define _HBMK_lDEPIMPLIB        136  /* Generate import libs configured in dependency specification */
#define _HBMK_lInstForce        137  /* Force to install target even if was up to date */
#define _HBMK_lAutoHBM          138  /* Toggles processing of '_HBMK_AUTOHBM_NAME' file in current directory */
#define _HBMK_lContainer        139  /* Target type: container */
#define _HBMK_lShowLevel        140  /* Show project nesting level in all output lines */
#define _HBMK_hFiles            141  /* Cache for the header parser (common for C and Harbour) */
#define _HBMK_cDynLibPrefix     142  /* Dynamic lib filename prefix */
#define _HBMK_cDynLibExt        143  /* Dynamic lib filename extension */
#define _HBMK_aLINK             144  /* Links to be created and pointing to the target */
#define _HBMK_hDEPTMACRO        145  /* Links to be created and pointing to the target */
#define _HBMK_cC                146  /* C dialect */
#define _HBMK_cCPP              147  /* C++ dialect */
#define _HBMK_aLIB_BASE_WARN    148

#define _HBMK_aArgs             149
#define _HBMK_nArgTarget        150
#define _HBMK_lPause            151
#define _HBMK_nLevel            152

#define _HBMK_cHBX              153
#define _HBMK_lHBXUpdate        154

#define _HBMK_aGT               155
#define _HBMK_cCPPRG            156

#define _HBMK_lSysLoc           157
#define _HBMK_lDumpInfo         158
#define _HBMK_lNoInfo           159
#define _HBMK_lMarkdown         160
#define _HBMK_lShellMode        161
#define _HBMK_bOut              162

#define _HBMK_cSignTime         163
#define _HBMK_lCLI              164
#define _HBMK_cPKGM             165
#define _HBMK_aHBCCON           166
#define _HBMK_lHaltRevCounters  167
#define _HBMK_lVCSTS            168
#define _HBMK_tVCSTS            169

#define _HBMK_nCmdLineMax       170
#define _HBMK_aCmdLineLen       171
#define _HBMK_lInitHBL          172

#define _HBMK_MAX_              172
#define _HBMK_DEP_CTRL_MARKER   ".control."  /* must be an invalid path */

#define _HBMKDEP_cName          1
#define _HBMKDEP_aURLBase       2
#define _HBMKDEP_aPKG           3
#define _HBMKDEP_aKeyHeader     4
#define _HBMKDEP_cControl       5
#define _HBMKDEP_aControlMacro  6
#define _HBMKDEP_lOptional      7
#define _HBMKDEP_cINCROOT       8
#define _HBMKDEP_aINCPATH       9
#define _HBMKDEP_aINCPATHLOCAL  10
#define _HBMKDEP_aIMPLIBSRC     11
#define _HBMKDEP_cIMPLIBDST     12
#define _HBMKDEP_cFound         13
#define _HBMKDEP_lFound         14
#define _HBMKDEP_lFoundLOCAL    15
#define _HBMKDEP_cVersion       16
#define _HBMKDEP_lForced        17
#define _HBMKDEP_lDetected      18
#define _HBMKDEP_MAX_           18

#define _EXIT_OK                0
#define _EXIT_UNKNPLAT          1
#define _EXIT_UNKNCOMP          2
#define _EXIT_FAILHBDETECT      3
#define _EXIT_STUBCREATE        5
#define _EXIT_PHASE_COMP        6
#define _EXIT_COMPPRG           _EXIT_PHASE_COMP
#define _EXIT_RUNRES            _EXIT_PHASE_COMP
#define _EXIT_COMPC             _EXIT_PHASE_COMP
#define _EXIT_PHASE_ASSEMBLY    7
#define _EXIT_RUNLINKER         _EXIT_PHASE_ASSEMBLY
#define _EXIT_RUNLIB            _EXIT_PHASE_ASSEMBLY
#define _EXIT_UNSUPPORTED       8
#define _EXIT_WORKDIRCREATE     9
#define _EXIT_HELP              19
#define _EXIT_MISSDEPT          10
#define _EXIT_PLUGINPREALL      20
#define _EXIT_DEEPPROJNESTING   30
#define _EXIT_STOP              50
#define HBMK_IS_IN( str, list ) ( "|" + ( str ) + "|" $ "|" + ( list ) + "|" )
#define HBMK_ISPLAT( list )     HBMK_IS_IN( hbmk[ _HBMK_cPLAT ], list )
#define HBMK_ISCOMP( list )     HBMK_IS_IN( hbmk[ _HBMK_cCOMP ], list )
#define PathMakeAbsolute( cPathR, cPathA ) hb_PathJoin( cPathA, cPathR )


/* Request for runner and shell */
EXTERNAL __HB_EXTERN__
/* Request some functions for plugins */
EXTERNAL HBClass
EXTERNAL __clsLockDef
EXTERNAL __hbdoc_LoadDir
EXTERNAL __hbdoc_ToSource
EXTERNAL __hbdoc_SaveHBD
EXTERNAL hb_regex
EXTERNAL hb_SHA256
EXTERNAL hb_SHA512
EXTERNAL hb_CRC32
EXTERNAL hb_blowfishKey
EXTERNAL hb_blowfishEncrypt
EXTERNAL hb_jsonEncode
EXTERNAL hb_jsonDecode
EXTERNAL hb_libExt
EXTERNAL hb_HKeyAt
EXTERNAL hb_HDelAt
EXTERNAL hb_HKeys
EXTERNAL hb_HKeepOrder
EXTERNAL hb_vfAttrGet
EXTERNAL hb_vfAttrSet
EXTERNAL hb_ZCompress
EXTERNAL hb_ZUncompress

/* For compatibility with existing plugins. Use hb_vf*() API instead. */
EXTERNAL Directory
EXTERNAL hb_DirCreate
EXTERNAL hb_DirDelete
EXTERNAL hb_DirExists
EXTERNAL hb_Directory
EXTERNAL hb_FGetAttr
EXTERNAL hb_FGetDateTime
EXTERNAL hb_FLink
EXTERNAL hb_FLinkRead
EXTERNAL hb_FLinkSym
EXTERNAL hb_FSetAttr
EXTERNAL hb_FSetDateTime
EXTERNAL hb_FSize
EXTERNAL hb_FTempCreate
EXTERNAL hb_FTempCreateEx
EXTERNAL hb_FileExists

/* For hbshell */

// EXTERNAL __dbgEntry

#define HB_HISTORY_LEN          2000
#define HB_LINE_LEN             256

#define _HBSH_cDirBase          1
#define _HBSH_cProgName         2
#define _HBSH_cScriptName       3
#define _HBSH_hLibExt           4
#define _HBSH_hCH               5
#define _HBSH_hOPTPRG           6
#define _HBSH_hINCPATH          7
#define _HBSH_hCHCORE           8
#define _HBSH_hbmk              9
#define _HBSH_nRow              10
#define _HBSH_nCol              11
#define _HBSH_aHistory          12
#define _HBSH_lPreserveHistory  13
#define _HBSH_lWasLoad          14
#define _HBSH_lInteractive      15
#define _HBSH_lClipperComp      16
#define _HBSH_MAX_              16

/* Allow to inject custom code at build-time. The goal is to help
   adding necessary customizations for certain use-case. */
#if defined( _HBMK2_EXTRA_CODE )
#include "hbmk2_extra.prg"
#endif

/* Trick to make it run if compiled without -n/-n1/-n2
   (or with -n-) option.
   (typically as scripts and precompiled scripts) */
/* NOTE: Avoid file wide STATICs to keep this working */
#if __pragma( n ) < 1
hbmk_local_entry( hb_ArrayToParams( hb_AParams() ) )
#endif

/* for GNU Make build (we cannot override default entry, so we use this alternate built-in one */
PROCEDURE _APPMAIN( ... )

   hbmk_local_entry( ... )

   RETURN


#define _EXT_FILE_NORMAL "hb_extension"
#define _EXT_FILE_MSDOS  "hb_ext.ini"
#define _EXT_FILE_       _EXT_FILE_MSDOS
#define _EXT_FILE_ALT    _EXT_FILE_NORMAL
#define _EXT_FILE_ALT_OS I_( "non-MS-DOS" )
#define _EXT_ENV_  "HB_EXTENSION"
