#!/usr/bin/env hbmk2

#include "directry.ch"
#include "fileio.ch"
#include "hbserial.ch"
#include "hbver.ch"

#pragma -w0
#pragma -es3

? "hello world"

mk_hb_vfCopyFile( "test.hb", "test.txt", .F.,, .T. )




/* Like hb_vfCopyFile(), but accepts dir as target, can set attributes
   and translates EOL to target platform */
STATIC PROCEDURE mk_hb_vfCopyFile( cSrc, cDst, lEOL, l644, lTS )

   LOCAL cDir, cName, cExt
   LOCAL cFile
   LOCAL tDate

   cSrc := hb_DirSepToOS( cSrc )
   cDst := hb_DirSepToOS( cDst )

   hb_FNameSplit( cDst, @cDir, @cName, @cExt )
   IF Empty( cName ) .AND. Empty( cExt )
      hb_FNameSplit( cSrc,, @cName, @cExt )
   ENDIF
   cDst := hb_FNameMerge( cDir, cName, cExt )

   IF !( cFile := hb_MemoRead( cSrc ) ) == "" .AND. ;
         hb_MemoWrit( cDst, iif( hb_defaultValue( lEOL, .F. ), EOLConv( cFile ), cFile ) )

      IF hb_defaultValue( lTS, .F. )
         mk_hb_vfTimeSet( cDst )
      ELSE
         hb_vfTimeGet( cSrc, @tDate )
         hb_vfTimeSet( cDst, tDate )
      ENDIF
      IF hb_defaultValue( l644, .F. )
         hb_vfAttrSet( cDst, hb_bitOr( HB_FA_WUSR, HB_FA_RUSR, HB_FA_RGRP, HB_FA_ROTH ) )
      ENDIF
   ENDIF

   RETURN



STATIC FUNCTION EOLConv( cFile )

    cFile := StrTran( cFile, Chr( 13 ) + Chr( 10 ), Chr( 10 ) )

    RETURN iif( GetEnvC( "HB_PLATFORM" ) == "win", ;
        StrTran( cFile, Chr( 10 ), Chr( 13 ) + Chr( 10 ) ), ;
        cFile )



STATIC FUNCTION mk_hb_vfTimeSet( cFileName )

   STATIC s_tVCS

   LOCAL cStdOut, cStdErr

   IF s_tVCS == NIL
      IF hb_processRun( "git log -1 --format=format:%ci",, @cStdOut, @cStdErr ) != 0
         cStdOut := hb_ATokens( hb_MemoRead( "include" + hb_ps() + "_repover.txt" ), .T. )
         cStdOut := iif( Len( cStdOut ) >= 2, cStdOut[ 2 ], "" )
      ENDIF

      s_tVCS := hb_CToT( cStdOut, "yyyy-mm-dd", "hh:mm:ss" )

      IF ! Empty( s_tVCS )
         s_tVCS -= ( ( ( iif( SubStr( cStdOut, 21, 1 ) == "-", - 1, 1 ) * 60 * ;
            ( Val( SubStr( cStdOut, 22, 2 ) ) * 60 + ;
            Val( SubStr( cStdOut, 24, 2 ) ) ) ) - hb_UTCOffset() ) / 86400 )
      ENDIF

      OutStd( hb_StrFormat( "! Repository timestamp (local): %1$s" + ;
         iif( Empty( s_tVCS ), "(not available)", hb_TToC( s_tVCS, "yyyy-mm-dd", "hh:mm:ss" ) ) ) + hb_eol() )
   ENDIF

   RETURN ;
      ! HB_ISSTRING( cFileName ) .OR. ;
      ! GetEnvC( "HB_BUILD_PKG" ) == "yes" .OR. ;
      Empty( s_tVCS ) .OR. ;
      hb_vfTimeSet( cFileName, s_tVCS )


STATIC FUNCTION GetEnvC( cEnvVar )

   STATIC s_hEnvCache := { => }

   IF cEnvVar $ s_hEnvCache
      RETURN s_hEnvCache[ cEnvVar ]
   ENDIF

   RETURN s_hEnvCache[ cEnvVar ] := GetEnv( cEnvVar )
