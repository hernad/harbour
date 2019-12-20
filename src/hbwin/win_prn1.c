/*
 * Printing subsystem for Windows using GUI printing
 *
 * Copyright 2004 Peter Rees <peter@rees.co.nz> Rees Software and Systems Ltd
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; see the file LICENSE.txt.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
 * Boston, MA 02110-1301 USA (or visit https://www.gnu.org/licenses/).
 *
 * As a special exception, the Harbour Project gives permission for
 * additional uses of the text contained in its release of Harbour.
 *
 * The exception is that, if you link the Harbour libraries with other
 * files to produce an executable, this does not by itself cause the
 * resulting executable to be covered by the GNU General Public License.
 * Your use of that executable is in no way restricted on account of
 * linking the Harbour library code into it.
 *
 * This exception does not however invalidate any other reasons why
 * the executable file might be covered by the GNU General Public License.
 *
 * This exception applies only to the code released by the Harbour
 * Project under the name Harbour.  If you copy code from other
 * Harbour Project or Free Software Foundation releases into a copy of
 * Harbour, as the General Public License permits, the exception does
 * not apply to the code that you add in this way.  To avoid misleading
 * anyone as to the status of such modified files, you must delete
 * this exception notice from them.
 *
 * If you write modifications of your own for Harbour, it is your choice
 * whether to permit this exception to apply to your modifications.
 * If you do not wish that, delete this exception notice.
 *
 */

#include "hbwapi.h"
#include "hbapifs.h"
#include "hbapiitm.h"

#if defined( HB_OS_WIN_CE )
   #if defined( __POCC__ )
      #ifndef FONTENUMPROC
      #define FONTENUMPROC  FONTENUMPROCW
      #endif
   #endif
#else
   #include <winspool.h>
#endif



HB_FUNC( WIN_GETCHARSIZE )
{
   long lResult = 0;
   HDC hDC = hbwapi_par_HDC( 1 );

   if( hDC )
   {
      TEXTMETRIC tm;

      GetTextMetrics( hDC, &tm );
      if( hb_parl( 2 ) )
         lResult = ( long ) tm.tmHeight;
      else
         lResult = ( long ) tm.tmAveCharWidth;
   }

   hb_retnl( lResult );
}


HB_FUNC( WIN_SETDOCUMENTPROPERTIES )
{
   HB_BOOL bResult = HB_FALSE;

#if ! defined( HB_OS_WIN_CE )
   HDC hDC = hbwapi_par_HDC( 1 );

   if( hDC )
   {
      HANDLE hPrinter;
      void * hDeviceName;
      LPCTSTR lpDeviceName = HB_PARSTR( 2, &hDeviceName, NULL );

      if( OpenPrinter( ( LPTSTR ) HB_UNCONST( lpDeviceName ), &hPrinter, NULL ) )
      {
         LONG lSize = DocumentProperties( 0, hPrinter, ( LPTSTR ) HB_UNCONST( lpDeviceName ), NULL, NULL, 0 );

         if( lSize > 0 )
         {
            PDEVMODE pDevMode = ( PDEVMODE ) hb_xgrabz( lSize );

            if( DocumentProperties( 0, hPrinter, ( LPTSTR ) HB_UNCONST( lpDeviceName ), pDevMode, pDevMode, DM_OUT_BUFFER ) == IDOK )
            {
               DWORD dmFields = 0, fMode;
               HB_BOOL fUserDialog;
               int iProp, iProp2;

               fUserDialog = HB_ISBYREF( 3 ) ||
                             HB_ISBYREF( 4 ) ||
                             HB_ISBYREF( 5 ) ||
                             HB_ISBYREF( 6 ) ||
                             HB_ISBYREF( 7 ) ||
                             HB_ISBYREF( 8 ) ||
                             HB_ISBYREF( 9 ) ||
                             HB_ISBYREF( 10 ) ||
                             HB_ISBYREF( 11 );

               if( ( iProp = hb_parni( 3 ) ) != 0 )      /* [2007-02-22] don't change if 0 */
               {
                  pDevMode->dmPaperSize = ( short ) iProp;
                  dmFields |= DM_PAPERSIZE;
               }

               if( HB_ISLOG( 4 ) )
               {
                  pDevMode->dmOrientation = ( short ) ( hb_parl( 4 ) ? DMORIENT_LANDSCAPE : DMORIENT_PORTRAIT );
                  dmFields |= DM_ORIENTATION;
               }

               if( ( iProp = hb_parni( 5 ) ) > 0 )
               {
                  pDevMode->dmCopies = ( short ) iProp;
                  dmFields |= DM_COPIES;

                  if( hb_parl( 11 ) )
                  {
                     pDevMode->dmCollate = DMCOLLATE_TRUE;
                     dmFields |= DM_COLLATE;
                  }
               }

               if( ( iProp = hb_parni( 6 ) ) != 0 )      /* [2007-02-22] don't change if 0 */
               {
                  pDevMode->dmDefaultSource = ( short ) iProp;
                  dmFields |= DM_DEFAULTSOURCE;
               }

               if( ( iProp = hb_parni( 7 ) ) != 0 )      /* [2007-02-22] don't change if 0 */
               {
                  pDevMode->dmDuplex = ( short ) iProp;
                  dmFields |= DM_DUPLEX;
               }

               if( ( iProp = hb_parni( 8 ) ) != 0 )      /* [2007-02-22] don't change if 0 */
               {
                  pDevMode->dmPrintQuality = ( short ) iProp;
                  dmFields |= DM_PRINTQUALITY;
               }

               if( pDevMode->dmPaperSize == DMPAPER_USER &&
                   ( iProp = hb_parni( 9 ) ) > 0 &&
                   ( iProp2 = hb_parni( 10 ) ) > 0 )
               {
                  pDevMode->dmPaperLength = ( short ) iProp;
                  pDevMode->dmPaperWidth = ( short ) iProp2;
                  dmFields |= DM_PAPERLENGTH | DM_PAPERWIDTH;
               }

               pDevMode->dmFields = dmFields;

               fMode = DM_IN_BUFFER | DM_OUT_BUFFER;
               if( fUserDialog )
                  fMode |= DM_IN_PROMPT;

               if( DocumentProperties( 0, hPrinter, ( LPTSTR ) HB_UNCONST( lpDeviceName ), pDevMode, pDevMode, fMode ) == IDOK )
               {
                  hb_storni( pDevMode->dmPaperSize, 3 );
                  hb_storl( pDevMode->dmOrientation == DMORIENT_LANDSCAPE, 4 );
                  hb_storni( pDevMode->dmCopies, 5 );
                  hb_storni( pDevMode->dmDefaultSource, 6 );
                  hb_storni( pDevMode->dmDuplex, 7 );
                  hb_storni( pDevMode->dmPrintQuality, 8 );
                  hb_storni( pDevMode->dmPaperLength, 9 );
                  hb_storni( pDevMode->dmPaperWidth, 10 );

                  bResult = ( ResetDC( hDC, pDevMode ) != NULL );
               }
            }

            hb_xfree( pDevMode );
         }

         ClosePrinter( hPrinter );
      }

      hb_strfree( hDeviceName );
   }
#endif

   hb_retl( bResult );
}

HB_FUNC( WIN_GETDOCUMENTPROPERTIES )
{
   HB_BOOL bResult = HB_FALSE;

#if ! defined( HB_OS_WIN_CE )
   HANDLE hPrinter;
   void * hDeviceName;
   LPCTSTR lpDeviceName = HB_PARSTR( 1, &hDeviceName, NULL );

   if( OpenPrinter( ( LPTSTR ) HB_UNCONST( lpDeviceName ), &hPrinter, NULL ) )
   {
      LONG lSize = DocumentProperties( 0, hPrinter, ( LPTSTR ) HB_UNCONST( lpDeviceName ), NULL, NULL, 0 );

      if( lSize > 0 )
      {
         PDEVMODE pDevMode = ( PDEVMODE ) hb_xgrabz( lSize );

         if( DocumentProperties( 0, hPrinter, ( LPTSTR ) HB_UNCONST( lpDeviceName ), pDevMode, pDevMode, DM_OUT_BUFFER ) == IDOK )
         {
            hb_storni( pDevMode->dmPaperSize, 2 );
            hb_storl( pDevMode->dmOrientation == DMORIENT_LANDSCAPE, 3 );
            hb_storni( pDevMode->dmCopies, 4 );
            hb_storni( pDevMode->dmDefaultSource, 5 );
            hb_storni( pDevMode->dmDuplex, 6 );
            hb_storni( pDevMode->dmPrintQuality, 7 );
            hb_storni( pDevMode->dmPaperLength, 8 );
            hb_storni( pDevMode->dmPaperWidth, 9 );
            hb_storl( pDevMode->dmCollate == DMCOLLATE_TRUE, 10 );
            bResult = HB_TRUE;
         }

         hb_xfree( pDevMode );
      }

      ClosePrinter( hPrinter );
   }

   hb_strfree( hDeviceName );
#endif

   hb_retl( bResult );
}

static int CALLBACK FontEnumCallBack( LOGFONT * lplf, TEXTMETRIC * lpntm,
                                      DWORD dwFontType, LPVOID pArray )
{
   PHB_ITEM pSubItems = hb_itemArrayNew( 4 );

   HB_ARRAYSETSTR( pSubItems, 1, lplf->lfFaceName );
   hb_arraySetL( pSubItems, 2, ( lplf->lfPitchAndFamily & FIXED_PITCH ) != 0 );
   hb_arraySetL( pSubItems, 3, ( dwFontType & TRUETYPE_FONTTYPE ) != 0 );
   hb_arraySetNL( pSubItems, 4, lpntm->tmCharSet );
   hb_arrayAddForward( ( PHB_ITEM ) pArray, pSubItems );

   hb_itemRelease( pSubItems );

   return 1;
}

HB_FUNC( WIN_ENUMFONTS )
{
   HDC hDC = hbwapi_par_HDC( 1 );
   HB_BOOL fNullDC = ( ! hDC );
   PHB_ITEM pArray = hb_itemArrayNew( 0 );

   if( fNullDC )
      hDC = GetDC( NULL );

   EnumFonts( hDC, NULL, ( FONTENUMPROC ) FontEnumCallBack, ( LPARAM ) pArray );

   if( fNullDC )
      ReleaseDC( NULL, hDC );

   hb_itemReturnRelease( pArray );
}

HB_FUNC( WIN_ENUMFONTFAMILIES )
{
   PHB_ITEM pArray = hb_itemArrayNew( 0 );
#if ! defined( HB_OS_WIN_CE )
   HDC hDC = hbwapi_par_HDC( 1 );
   HB_BOOL fNullDC = ( ! hDC );
   LOGFONT lf;

   memset( &lf, 0, sizeof( lf ) );

   lf.lfCharSet = ( BYTE ) hb_parnidef( 1, DEFAULT_CHARSET );
   if( HB_ISCHAR( 2 ) )
   {
      void * hText;
      HB_STRNCPY( lf.lfFaceName, HB_PARSTR( 2, &hText, NULL ), HB_SIZEOFARRAY( lf.lfFaceName ) - 1 );
      hb_strfree( hText );
   }

   if( fNullDC )
      hDC = GetDC( NULL );

   EnumFontFamiliesEx( hDC, &lf, ( FONTENUMPROC ) FontEnumCallBack, ( LPARAM ) pArray, 0 );

   if( fNullDC )
      ReleaseDC( NULL, hDC );
#endif

   hb_itemReturnRelease( pArray );
}

HB_FUNC( WIN_SETPEN )
{
   HDC hDC = hbwapi_par_HDC( 1 );

   if( hDC )
   {
      HPEN hPen;

      if( HB_ISPOINTER( 2 ) )
         hPen = hbwapi_par_HPEN( 2 );
      else
      {
         hPen = CreatePen( hb_parni( 2 ),  /* pen style */
                           hb_parni( 3 ),  /* pen width */
                           hbwapi_par_COLORREF( 4 ) );  /* pen color */

         hbwapi_ret_HPEN( hPen );
      }

      if( hPen )
         SelectObject( hDC, hPen );
   }
   else
      hb_retptr( NULL );
}

