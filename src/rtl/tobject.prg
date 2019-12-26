/*
 * Base Object from which all object finally inherit
 *
 * Copyright 2000 J. Lefebvre <jfl@mafact.com> and RA. Cuylen <rac@mafact.com>
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

/* WARNING: Cannot use the preprocessor, otherwise
            it will auto inherit from itself. */

#include "hboo.ch"
#include "error.ch"

FUNCTION HBObject()

   STATIC s_oClass
   LOCAL oClass

   IF s_oClass == NIL .AND. __clsLockDef( @s_oClass )

      BEGIN SEQUENCE

         oClass := HBClass():New( "HBObject",, @HBObject() )

         oClass:AddInline( "ISDERIVEDFROM"   , {| Self, xPar1 | __objDerivedFrom( Self, xPar1 ) }, HB_OO_CLSTP_EXPORTED ) /* Xbase++ compatibility */

         /* Class(y) */
         oClass:AddInline( "ISKINDOF"        , {| Self, xPar1 | __objDerivedFrom( Self, xPar1 ) }, HB_OO_CLSTP_EXPORTED )

         oClass:AddMethod( "NEW"  , @HBObject_New()   , HB_OO_CLSTP_EXPORTED )
         oClass:AddMethod( "INIT" , @HBObject_Init()  , HB_OO_CLSTP_EXPORTED )

         oClass:AddMethod( "ERROR", @HBObject_Error() , HB_OO_CLSTP_EXPORTED )

         oClass:SetOnError( @HBObject_DftonError() )

         oClass:AddInline( "MSGNOTFOUND"     , {| Self, cMsg | ::Error( "Message not found", ::className(), cMsg, iif( hb_LeftEq( cMsg, "_" ), 1005, 1004 ) ) }, HB_OO_CLSTP_EXPORTED )

         oClass:Create()

      ALWAYS

         __clsUnlockDef( @s_oClass, oClass )

      END SEQUENCE

   ENDIF


   RETURN s_oClass:Instance()

STATIC FUNCTION HBObject_New( ... )

   QSelf():Init( ... )

   RETURN QSelf()

STATIC FUNCTION HBObject_Init()
   RETURN QSelf()

STATIC FUNCTION HBObject_Dftonerror( ... )
   RETURN QSelf():MsgNotFound( __GetMessage(), ... )

STATIC FUNCTION HBObject_Error( cDesc, cClass, cMsg, nCode )

   hb_default( @nCode, 1004 )

   RETURN __errRT_SBASE( iif( nCode == 1005, EG_NOVARMETHOD, EG_NOMETHOD ), nCode, cDesc, cClass + ":" + cMsg, 1, QSelf() )
