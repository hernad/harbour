/*
 * OpenSSL API (PEM) - Harbour interface.
 *
 * Copyright 2009-2016 Viktor Szakats (vszakats.net/harbour)
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

#include "hbssl.h"

#include "hbapifs.h"
#include "hbapiitm.h"
#include "hbvm.h"

typedef enum
{
   hb_PEM_X509,
   hb_PEM_EVP_PKEY,
   hb_PEM_ANY
} HB_PEM_TYPES;

/* Callback */

static int hb_ssl_pem_password_cb( char * buf, int size, int rwflag, void * userdata )
{
   int retsize = 0;

   if( size > 0 && userdata && hb_vmRequestReenter() )
   {
      hb_vmPushEvalSym();
      hb_vmPush( ( PHB_ITEM ) userdata );
      hb_vmPushLogical( rwflag );
      hb_vmSend( 1 );

      buf[ 0 ] = '\0';

      retsize = ( int ) hb_parclen( -1 );

      if( retsize > 0 )
      {
         if( retsize > size )
            retsize = size;

         memcpy( buf, hb_parc( -1 ), retsize );
      }

      hb_vmRequestRestore();
   }

   return retsize;
}

HB_FUNC( ERR_LOAD_PEM_STRINGS )
{
   ERR_load_PEM_strings();
}

typedef void * PEM_READ_BIO ( BIO * bp, void ** x, pem_password_cb * cb, void * u );
typedef void * PEM_WRITE_BIO ( BIO * bp, void ** x, pem_password_cb * cb, void * u );

static void hb_PEM_read_bio( PEM_READ_BIO * func, HB_PEM_TYPES type )
{
   BIO * bio = NULL;
   HB_BYTE * pBuffer = NULL;
   HB_SIZE nSize = 0;

   if( hb_BIO_is( 1 ) )
      bio = hb_BIO_par( 1 );
   else if( HB_ISCHAR( 1 ) )
   {
      pBuffer = hb_fileLoad( hb_parc( 1 ), 0, &nSize );
      if( pBuffer )
         bio = BIO_new_mem_buf( ( char * ) pBuffer, ( int ) nSize );
   }
   else if( HB_IS_PARAM_NUM( 1 ) )
      bio = BIO_new_fd( hb_parni( 1 ), BIO_NOCLOSE );

   if( bio )
   {
      PHB_ITEM pPassCallback = hb_param( 2, HB_IT_EVALITEM );
      pem_password_cb * cb;
      void * cargo, * result;

      if( pPassCallback )
      {
         cb = hb_ssl_pem_password_cb;
         cargo = pPassCallback;
      }
      else
      {
         cb = NULL;
         cargo = HB_UNCONST( hb_parc( 2 ) );  /* NOTE: Discarding 'const' qualifier, OpenSSL will memcpy() it */
      }

      result = ( *func )( bio, NULL, cb, cargo );

      if( result )
      {
         switch( type )
         {
            case hb_PEM_X509:
               hb_X509_ret( ( X509 * ) result, HB_TRUE );
               break;
            case hb_PEM_EVP_PKEY:
               hb_EVP_PKEY_ret( ( EVP_PKEY * ) result );
               break;
            case hb_PEM_ANY:
               hb_retptr( NULL );
               break;
         }
      }
      else
         hb_retptr( NULL );

      if( ! hb_BIO_is( 1 ) )
         BIO_free( bio );

      if( pBuffer )
      {
         OPENSSL_cleanse( pBuffer, ( size_t ) nSize );
         hb_xfree( pBuffer );
      }
   }
   else
      hb_errRT_BASE( EG_ARG, 2010, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
}

HB_FUNC( PEM_READ_BIO_PRIVATEKEY    ) { hb_PEM_read_bio( ( PEM_READ_BIO * ) PEM_read_bio_PrivateKey   , hb_PEM_ANY ); }
HB_FUNC( PEM_READ_BIO_PUBKEY        ) { hb_PEM_read_bio( ( PEM_READ_BIO * ) PEM_read_bio_PUBKEY       , hb_PEM_ANY ); }
HB_FUNC( PEM_READ_BIO_RSAPRIVATEKEY ) { hb_PEM_read_bio( ( PEM_READ_BIO * ) PEM_read_bio_RSAPrivateKey, hb_PEM_ANY ); }
HB_FUNC( PEM_READ_BIO_RSAPUBLICKEY  ) { hb_PEM_read_bio( ( PEM_READ_BIO * ) PEM_read_bio_RSAPublicKey , hb_PEM_ANY ); }
HB_FUNC( PEM_READ_BIO_RSA_PUBKEY    ) { hb_PEM_read_bio( ( PEM_READ_BIO * ) PEM_read_bio_RSA_PUBKEY   , hb_PEM_ANY ); }
HB_FUNC( PEM_READ_BIO_DSAPRIVATEKEY ) { hb_PEM_read_bio( ( PEM_READ_BIO * ) PEM_read_bio_DSAPrivateKey, hb_PEM_ANY ); }
HB_FUNC( PEM_READ_BIO_DSA_PUBKEY    ) { hb_PEM_read_bio( ( PEM_READ_BIO * ) PEM_read_bio_DSA_PUBKEY   , hb_PEM_ANY ); }
HB_FUNC( PEM_READ_BIO_DSAPARAMS     ) { hb_PEM_read_bio( ( PEM_READ_BIO * ) PEM_read_bio_DSAparams    , hb_PEM_ANY ); }
HB_FUNC( PEM_READ_BIO_DHPARAMS      ) { hb_PEM_read_bio( ( PEM_READ_BIO * ) PEM_read_bio_DHparams     , hb_PEM_ANY ); }
HB_FUNC( PEM_READ_BIO_X509          ) { hb_PEM_read_bio( ( PEM_READ_BIO * ) PEM_read_bio_X509         , hb_PEM_ANY ); }
HB_FUNC( PEM_READ_BIO_X509_AUX      ) { hb_PEM_read_bio( ( PEM_READ_BIO * ) PEM_read_bio_X509_AUX     , hb_PEM_ANY ); }
HB_FUNC( PEM_READ_BIO_X509_REQ      ) { hb_PEM_read_bio( ( PEM_READ_BIO * ) PEM_read_bio_X509_REQ     , hb_PEM_ANY ); }
HB_FUNC( PEM_READ_BIO_X509_CRL      ) { hb_PEM_read_bio( ( PEM_READ_BIO * ) PEM_read_bio_X509_CRL     , hb_PEM_ANY ); }
HB_FUNC( PEM_READ_BIO_PKCS7         ) { hb_PEM_read_bio( ( PEM_READ_BIO * ) PEM_read_bio_PKCS7        , hb_PEM_ANY ); }

HB_FUNC( PEM_READ_X509              ) { hb_PEM_read_bio( ( PEM_READ_BIO * ) PEM_read_bio_X509         , hb_PEM_X509 ); }
HB_FUNC( PEM_READ_X509_AUX          ) { hb_PEM_read_bio( ( PEM_READ_BIO * ) PEM_read_bio_X509_AUX     , hb_PEM_X509 ); }
HB_FUNC( PEM_READ_PRIVATEKEY        ) { hb_PEM_read_bio( ( PEM_READ_BIO * ) PEM_read_bio_PrivateKey   , hb_PEM_EVP_PKEY ); }
HB_FUNC( PEM_READ_PUBKEY            ) { hb_PEM_read_bio( ( PEM_READ_BIO * ) PEM_read_bio_PUBKEY       , hb_PEM_EVP_PKEY ); }

#if 0

int PEM_write_bio_RSAPrivateKey(       BIO * bp, RSA      * x, const EVP_CIPHER * enc, unsigned char * kstr, int klen, pem_password_cb * cb, void * u );
int PEM_write_bio_DSAPrivateKey(       BIO * bp, DSA      * x, const EVP_CIPHER * enc, unsigned char * kstr, int klen, pem_password_cb * cb, void * u );
int PEM_write_bio_PrivateKey(          BIO * bp, EVP_PKEY * x, const EVP_CIPHER * enc, unsigned char * kstr, int klen, pem_password_cb * cb, void * u );
int PEM_write_bio_PKCS8PrivateKey(     BIO * bp, EVP_PKEY * x, const EVP_CIPHER * enc, char * kstr, int klen, pem_password_cb * cb, void * u );
int PEM_write_bio_PKCS8PrivateKey_nid( BIO * bp, EVP_PKEY * x, int nid, char * kstr, int klen, pem_password_cb * cb, void * u );
int PEM_write_bio_PUBKEY(              BIO * bp, EVP_PKEY * x );
int PEM_write_bio_RSAPublicKey(        BIO * bp, RSA * x );
int PEM_write_bio_RSA_PUBKEY(          BIO * bp, RSA * x );
int PEM_write_bio_DSA_PUBKEY(          BIO * bp, DSA * x );
int PEM_write_bio_DSAparams(           BIO * bp, DSA * x );
int PEM_write_bio_DHparams(            BIO * bp, DH * x );
int PEM_write_bio_X509(                BIO * bp, X509 * x );
int PEM_write_bio_X509_AUX(            BIO * bp, X509 * x );
int PEM_write_bio_X509_REQ(            BIO * bp, X509_REQ * x );
int PEM_write_bio_X509_REQ_NEW(        BIO * bp, X509_REQ * x );
int PEM_write_bio_X509_CRL(            BIO * bp, X509_CRL * x );
int PEM_write_bio_PKCS7(               BIO * bp, PKCS7 * x );

#endif
