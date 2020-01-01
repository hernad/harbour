#include "hbtest.ch"

REQUEST DBFCDX
REQUEST DBFFPT

STATIC s_cDbfEngine := "DBFCDX"

/*
---------------------------------------------------------------------------                                                       
    Version: Harbour 4.7.2hernad (a017e825) (2019-12-30 19:37)                                                                    
   Compiler: GNU C 4.8.5 (64-bit)
         OS: Linux 5.3.16-200.fc30.x86_64 x86_64
 Date, Time: 2020-01-01 12:27:07
===========================================================================
  Location    Test                                     -> Result
---------------------------------------------------------------------------
  MAIN(35)    Trim(field->large_fiel)                  -> "Content of large file 01"
! MAIN(37)    Trim(field->large_field_name)              
       Result: "E 14 BASE 1003 Variable does not exist (LARGE_FIELD_NAME) OS:0 #:1 F:R"
     Expected: "Content of large file 01"
===========================================================================
Test calls passed:          1 (  50.00 % )
Test calls failed:          1 (  50.00 % )
                   ----------         
            Total:          2 ( Time elapsed: 7 ms )
*/

PROCEDURE Main()

    LOCAL cTableName := "my_table_with_large_fields"
    LOCAL cAlias

    cAlias := cTableName

    create_dbf(cTableName)

    // new area
    dbUseArea( .T., s_cDbfEngine,  cTableName, cAlias, .F., .F. )

    
    APPEND BLANK
    replace id with '01', ;
        large_fiel with 'Content of large file 01', ;
        short_n with 'some stuff'

    // the same thing as APPEND BLANK
    dbAppend()
    replace id with '02', ;
        large_fiel with 'Content of large file 02', ;
        short_n with 'some stuff'

    dbGoto(1)

    // the field is silently trimmed to 10 chars 
    HBTEST Trim(field->large_fiel)  IS 'Content of large file 01'
    // so this field doesn't exist in the DBF table
    HBTEST Trim(field->large_field_name)  IS 'Content of large file 01'

    RETURN




FUNCTION create_dbf(cTableName)

    LOCAL aDbf := {}


    AAdd( aDBf, { 'ID', 'C',   2,  0 } )
    AAdd( aDBf, { 'large_field_name', 'C',   100,  0 } )
    AAdd( aDBf, { 'short_n' , 'C',   100,  0 } )


    RETURN dbCreate( cTableName, aDbf, s_cDbfEngine )




