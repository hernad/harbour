/*
 * Demonstration/test code for alternative RDD IO API which uses own
 * very simple TCP/IP file server.
 *
 * Copyright 2009 Przemyslaw Czerpak <druzus / at / priv.onet.pl>
 */

#include "hbnetio.ch"
//#require "hbnetio"


/* net:localhost:2941:topsecret:data/test.dbf */


/* few PP rules which allow to execute RPC function using
 * pseudo object 'net', i.e. ? net:date()
 */
#xtranslate net:<!func!>( [<params,...>] ) => ;
            netio_FuncExec( #<func> [,<params>] )
#xtranslate net:[<server>]:<!func!>( [<params,...>] ) => ;
            netio_FuncExec( [ #<server> + ] ":" + #<func> [,<params>] )
#xtranslate net:[<server>]:<port>:<!func!>( [<params,...>] ) => ;
            netio_FuncExec( [ #<server> + ] ":" + #<port> + ":" + #<func> ;
                            [,<params>] )

#xtranslate net:exists:<!func!> => ;
            netio_ProcExists( #<func> )
#xtranslate net:exists:[<server>]:<!func!> => ;
            netio_ProcExists( [ #<server> + ] ":" + #<func> )
#xtranslate net:exists:[<server>]:<port>:<!func!> => ;
            netio_ProcExists( [ #<server> + ] ":" + #<port> + ":" + #<func> )

#define NUM_RECORDS 100000
#define ROOT_DIR  "netio_root"
// start_server.sh:
// ROOT_DIR=netio_root
// netio -d -pass=topsecret -rootdir=`pwd`/$ROOT_DIR -rpc=rpc_processor.hb

#define DBSERVER  "localhost"
#define DBPORT    2941
#define DBPASSWD  "topsecret"

#define DBFDIR     "dbfs"
#define DBFILE    "test.dbf"

#define DBNAME    "net:" + DBSERVER + ":" + hb_ntos( DBPORT ) + ":" + ;
                  DBPASSWD + ":" + "./" +  DBFDIR + "/" + DBFILE

REQUEST DBFCDX

REQUEST hb_DirExists
REQUEST hb_DirCreate

PROCEDURE Main()

   LOCAL lExists
   LOCAL lConnect
   LOCAL cDbfsDir

   Set( _SET_EXCLUSIVE, .F. )
   rddSetDefault( "DBFCDX" )

   ? "SERVER ROOT:", ROOT_DIR
   lConnect := netio_Connect( DBSERVER, DBPORT, , DBPASSWD )
   ?
   ? "netio_Connect():", lConnect
   ?

   IF !lConnect
      ? "Cannot connect to ", DBSERVER, DBPORT, DBPASSWD
      QUIT
   ENDIF


   /* check if some function are available on server side */
   ? "Date() function is supported:",        net:exists:DATE
   ? net:DATE()
   ? "QOut() function is supported:",        net:exists:QOUT
   ? "hb_DateTime() function is supported:", net:exists:HB_DATETIME
   ? net:hb_dateTime()
   ?

   ? "hb_DirExists() function is supported", net:exists:HB_DIREXISTS
   ? "hb_DirCreate() function is supported", net:exists:HB_DIRCREATE

   cDbfsDir := ROOT_DIR + "/" + DBFDIR
   lExists := netio_FuncExec( "hb_DirExists", cDbfsDir  )
   ? "lExists=", lExists

   IF lExists != NIL .AND. ! lExists
      ? "Creating directory [" + cDbfsDir + "] ->", ;
         iif( netio_FuncExec( "hb_DirCreate", cDbfsDir ) == -1, "error", "OK" )
   ENDIF

   lExists := netio_FuncExec( "hb_DirExists", "./dataNEMA"  )
   ? "dir './dataNema' lExists=", lExists


   ? "'" + DBNAME + "'"
   createdb( DBNAME )
   testdb( DBNAME )
   WAIT

   ?
   ? "table exists:", dbExists( DBNAME )
   WAIT

   ?
   ? "delete table with indexes:", dbDrop( DBNAME )
   ? "table exists:", dbExists( DBNAME )
   WAIT

   ? "netio_Disconnect():", netio_Disconnect( DBSERVER, DBPORT )

   RETURN



PROCEDURE createdb( cName )  /* must be a public function */

   LOCAL n, nCnt

   dbCreate( cName, { ;
      { "F1", "C", 20, 0 }, ;
      { "F2", "M",  4, 0 }, ;
      { "F3", "N", 10, 2 }, ;
      { "F4", "T",  8, 0 } } )
   ? "create NetErr():", NetErr(), hb_osError()
   USE ( cName )
   ? "use NetErr():", NetErr(), hb_osError()

   nCnt := 0
   DO WHILE LastRec() < NUM_RECORDS
      ? ++nCnt
      dbAppend()
      n := RecNo() - 1
      field->F1 := Chr( n % 26 + Asc( "A" ) ) + " " + Time()
      field->F2 := field->F1
      field->F3 := n / 100
      field->F4 := hb_DateTime()
   ENDDO
   INDEX ON field->F1 TAG T1
   INDEX ON field->F3 TAG T3
   INDEX ON field->F4 TAG T4
   dbCloseArea()
   ?

   RETURN

PROCEDURE testdb( cName )  /* must be a public function */

   LOCAL i, j

   USE ( cName )
   ? "Used():", Used()
   ? "NetErr():", NetErr()
   ? "Alias():", Alias()
   ? "LastRec():", LastRec()
   ? "ordCount():", ordCount()
   FOR i := 1 TO ordCount()
      ordSetFocus( i )
      ? i, "name:", ordName(), "key:", ordKey(), "keycount:", ordKeyCount()
   NEXT
   ordSetFocus( 1 )
   dbGoTop()
   DO WHILE ! Eof()
      IF ! field->F1 == field->F2
         ? "error at record:", RecNo()
         ? "  !", "'" + field->F1 + "'", "==", "'" + field->F2 + "'"
      ENDIF
      dbSkip()
   ENDDO
   WAIT
   i := Row()
   j := Col()
   dbGoTop()
   Browse()
   SetPos( i, j )
   dbCloseArea()

   RETURN
