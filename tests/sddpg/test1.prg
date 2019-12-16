
#require "rddsql"
#require "sddpg"

#include "hbrddsql.ch"
#include "error.ch"

REQUEST SDDPG
REQUEST SQLMIX
REQUEST HB_CODEPAGE_UTF8
REQUEST HB_CODEPAGE_SL852
REQUEST HB_CODEPAGE_SLISO
REQUEST HB_CODEPAGE_SLWIN

ANNOUNCE RDDSYS

FIELD RESIDENTS, CODE, NAME

PROCEDURE Main()

   LOCAL hSqlParams, oServer, pConn

   hb_cdpSelect( "SL852" )

   ? "RDDs:"; AEval( rddList(), {| x | QQOut( "", x ) } )

   hSqlParams := hb_hash()
   hSqlParams[ "host" ] := "192.168.168.1"
   hSqlParams[ "database" ] := "bringout"
   hSqlParams[ "user" ] := "user"
   hSqlParams[ "password" ] := "userpassword"
   hSqlParams[ "port" ] := 5432
   hSqlParams[ "schema" ] := "fmk"

   oServer := TPQServer():New( hSqlParams[ "host" ], ;
      hSqlParams[ "database" ], ;
      hSqlParams[ "user" ], ;
      hSqlParams[ "password" ], ;
      hSqlParams[ "port" ], ;
      hSqlParams[ "schema" ] )

   IF oServer:NetErr()
      Alert(oServer:ErrorMsg())
      RETURN
   ENDIF

   ? "oServer", oServer:pDb

   pConn := oServer:pDb

   IF pConn == NIL
      ? "SQLMIX pDB NIL?! "
      RETURN
   ENDIF

   rddSetDefault( "SQLMIX" )
   IF rddInfo( RDDI_CONNECT, { "POSTGRESQL", pConn } ) == 0 
      ? "Unable connect to the PSQLserver"
      RETURN 
   ENDIF


   CreateCountryTable()

   dbUseArea( .T., , "SELECT * FROM country", "country" )
   Browse()

   dbUseArea( .T., , "SELECT * FROM tnal", "tnal" )
   Browse()

   INDEX ON field->naz TAG naz
   Browse()

   dbCloseArea()


   RETURN

STATIC PROCEDURE CreateCountryTable()

   LOCAL nI

   ? rddInfo( RDDI_EXECUTE, "DROP TABLE country" )
   ? rddInfo( RDDI_EXECUTE, "CREATE TABLE country " + ;
      "(CODE char(3), NAME char(50), RESIDENTS int)" )
   ? rddInfo( RDDI_EXECUTE, "INSERT INTO country values " + ;
      "('LTU', 'Lithuania', 3369600), " + ;
      "('USA', 'United States of America', 305397000), " + ;
      "('POR', 'Portugal', 10617600), " + ;
      "('POL', 'Poland', 38115967), " + ;
      "('AUS', 'Australia', 21446187), " + ;
      "('FRA', 'France', 64473140), " + ;
      "('RUS', 'Russia', 141900000)" )

   FOR nI := 1 TO 100
      rddInfo( RDDI_EXECUTE, "INSERT INTO country VALUES " + ;
         "('" + StrZero( nI, 3 ) + "', 'TestSQL " + hb_ntos( nI ) + "', 3369600)")
   NEXT

   RETURN

