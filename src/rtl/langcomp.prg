/*
 * The Language API module selection
 *
 * Copyright 2012 Viktor Szakats (vszakats.net/harbour)
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


FUNCTION hb_langSelect( cLangID, cCP )

   LOCAL tmp
   LOCAL cCPDef
   LOCAL cLangIDBase

   IF HB_ISSTRING( cLangID )

      cCPDef := hb_cdpSelect()


      IF ! HB_ISSTRING( cCP )
         cCP := cCPDef
      ENDIF

         /* Support standard ISO language IDs */
         IF ( tmp := __LangStdToLangHb( cLangID ) ) != NIL
            cLangID := tmp
         ENDIF
         cLangIDBase := cLangID

      IF ! hb_cdpIsUTF8( cCP )
         cLangID += "." + cCP
         hb_langNew( cLangID, cCP, cLangIDBase, "UTF8" )
      ENDIF
   ENDIF

   RETURN __hb_langSelect( cLangID )

STATIC FUNCTION __LangStdToLangHb( cLangStd )

   IF HB_ISSTRING( cLangStd )
      SWITCH Lower( StrTran( cLangStd, "_", "-" ) )
      CASE "be"         ; RETURN "be"
      CASE "bg-bg"
      CASE "bg"         ; RETURN "bg"
      CASE "ca-es"
      CASE "ca"         ; RETURN "ca"
      CASE "cs-cz"
      CASE "cs"         ; RETURN "cs"
      CASE "de-at"      ; RETURN "de_at"
      CASE "de-ch"
      CASE "de-de"
      CASE "de-li"
      CASE "de-lu"
      CASE "de"         ; RETURN "de"
      CASE "el-gr"
      CASE "el"         ; RETURN "el"
      CASE "en-au"
      CASE "en-bz"
      CASE "en-ca"
      CASE "en-cb"
      CASE "en-gb"
      CASE "en-ie"
      CASE "en-jm"
      CASE "en-nz"
      CASE "en-ph"
      CASE "en-tt"
      CASE "en-us"
      CASE "en-za"
      CASE "en-zw"
      CASE "en"         ; RETURN "en"
      CASE "eo"         ; RETURN "eo"
      CASE "es-419"     ; RETURN "es_419"
      CASE "es-ar"
      CASE "es-bo"
      CASE "es-cl"
      CASE "es-co"
      CASE "es-cr"
      CASE "es-do"
      CASE "es-ec"
      CASE "es-es"
      CASE "es-gt"
      CASE "es-hn"
      CASE "es-mx"
      CASE "es-ni"
      CASE "es-pa"
      CASE "es-pe"
      CASE "es-pr"
      CASE "es-py"
      CASE "es-sv"
      CASE "es-uy"
      CASE "es-ve"
      CASE "es"         ; RETURN "es"
      CASE "eu-es"
      CASE "eu"         ; RETURN "eu"
      CASE "fr-be"
      CASE "fr-ca"
      CASE "fr-ch"
      CASE "fr-fr"
      CASE "fr-lu"
      CASE "fr-mc"
      CASE "fr"         ; RETURN "fr"
      CASE "gl-es"
      CASE "gl"         ; RETURN "gl"
      CASE "he-il"
      CASE "he"         ; RETURN "he"
      CASE "hr-hr"
      CASE "hr"         ; RETURN "hr"
      CASE "hu-hu"
      CASE "hu"         ; RETURN "hu"
      CASE "id-id"
      CASE "id"         ; RETURN "id"
      CASE "is-is"
      CASE "is"         ; RETURN "is"
      CASE "it-ch"
      CASE "it-it"
      CASE "it"         ; RETURN "it"
      CASE "ko-kr"
      CASE "ko"         ; RETURN "ko"
      CASE "lt-lt"
      CASE "lt"         ; RETURN "lt"
      CASE "nl-be"
      CASE "nl-nl"
      CASE "nl"         ; RETURN "nl"
      CASE "pl-pl"
      CASE "pl"         ; RETURN "pl"
      CASE "pt-br"      ; RETURN "pt_br"
      CASE "pt-pt"
      CASE "pt"         ; RETURN "pt"
      CASE "ro-ro"
      CASE "ro"         ; RETURN "ro"
      CASE "ru-ru"
      CASE "ru"         ; RETURN "ru"
      CASE "sk-sk"
      CASE "sk"         ; RETURN "sk"
      CASE "sl-si"
      CASE "sl"         ; RETURN "sl"
      CASE "sr-sp-cyrl" ; RETURN "sr_cyr"
      CASE "sr-sp-latn" ; RETURN "sr_lat"
      CASE "sv-fi"
      CASE "sv-se"
      CASE "sv"         ; RETURN "sv"
      CASE "tr-tr"
      CASE "tr"         ; RETURN "tr"
      CASE "uk-ua"
      CASE "uk"         ; RETURN "uk"
      CASE "zh-chs"     ; RETURN "zh_sim"
      CASE "zh-cht"
      CASE "zh-cn"
      CASE "zh-hk"
      CASE "zh-mo"
      CASE "zh-sg"
      CASE "zh-tw"
      CASE "zh"         ; RETURN "zh"
      ENDSWITCH
   ENDIF

   RETURN NIL
