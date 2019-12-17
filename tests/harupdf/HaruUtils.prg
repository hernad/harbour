// #define __NODEBUG__
#include 'debug.ch'
/*
 * Proyecto: PdfPrinter
 * Fichero: HaruUtils.prg
 * Descripci�n:
 * Autor:
 * Fecha: 22/02/2017
 */


#xcommand TRY  => BEGIN SEQUENCE WITH {| oErr | Break( oErr ) }
#xcommand CATCH [<!oErr!>] => RECOVER [USING <oErr>] <-oErr->
#xcommand FINALLY => ALWAYS
#xtranslate Throw( <oErr> ) => ( Eval( ErrorBlock(), <oErr> ), Break( <oErr> ) )

FUNCTION HaruOpenPdf( cPdf )

   LOCAL lOk := .T.

#if defined( __PLATFORM_LINUX )

   hb_run("xdg-open " + cPdf)
#else
   hb_run("start " + cPdf)

#endif

RETURN lOk
