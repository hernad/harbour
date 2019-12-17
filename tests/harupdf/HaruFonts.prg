/*
 * Proyecto: PdfPrinter
 * Fichero: HaruFonts.prg
 * Descripcion:
 * Autor:
 * Fecha: 26/08/2014
 */


#define CSIDL_FONTS 0x0014

STATIC aTtfFontList:= NIL
STATIC cFontDir


//------------------------------------------------------------------------------
FUNCTION SetHaruFontDir(cDir)

   LOCAL cPrevValue:= cFontDir
   IF ValType( cDir ) == 'C' .AND. HB_DirExists( cDir )
      cFontDir:= cDir
   ENDIF
RETURN cPrevValue


//------------------------------------------------------------------------------
FUNCTION GetHaruFontDir()

   IF cFontDir == NIL
      // cFontDir:= HaruGetSpecialFolder( CSIDL_FONTS )
      cFontDir := "."
   ENDIF

RETURN cFontDir


//------------------------------------------------------------------------------
FUNCTION GetHaruFontList()

   IF aTtfFontList == NIL
      InitTtfFontList()
   ENDIF
RETURN aTtfFontList


//------------------------------------------------------------------------------
STATIC FUNCTION InitTtfFontList()
   LOCAL aDfltList:= { { 'Arial', 'arial.ttf' } ;
                     , { 'Verdana', 'verdana.ttf' } ;
                     , { 'Courier New', 'cour.ttf' } ;
                     , { 'Calibri', 'calibri.ttf' } ;
                     , { 'Tahoma', 'tahoma.ttf' } ;
                     }

   aTtfFontList:= {}
   aEval( aDfltList, {|_x| HaruAddFont( _x[1], _x[2] ) } )

RETURN NIL


//------------------------------------------------------------------------------
FUNCTION HaruAddFont( cFontName, cTtfFile )

   LOCAL aList := GetHaruFontList()
   IF !File( cTtfFile ) .AND. File( GetHaruFontDir() + hb_ps() + cTtfFile )
      cTtfFile:= GetHaruFontDir() + hb_ps() + cTtfFile
   ENDIF
   IF File( cTtfFile )
      aAdd( aList, { cFontName, cTtfFile } )
   ELSE
      Alert( 'Font not exists: '+ cTtfFile )
   ENDIF

RETURN NIL



