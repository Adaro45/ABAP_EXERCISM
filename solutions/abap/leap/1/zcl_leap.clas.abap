CLASS zcl_leap DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS leap
      IMPORTING
        year          TYPE i
      RETURNING
        VALUE(result) TYPE abap_bool.
ENDCLASS.

CLASS zcl_leap IMPLEMENTATION.

  METHOD leap.
    " REGLA 1: Si NO es divisible por 4, NO es bisiesto
  IF year MOD 4 <> 0.
    result = abap_false.
    RETURN.
  ENDIF.

  " REGLA 2: Si es divisible por 4 pero NO por 100, ES bisiesto
  IF year MOD 100 <> 0.
    result = abap_true.
    RETURN.
  ENDIF.

  " REGLA 3: Si es divisible por 100, debe ser divisible por 400 para ser bisiesto
  IF year MOD 400 = 0.
    result = abap_true.
  ELSE.
    result = abap_false.
  ENDIF.
  
  ENDMETHOD.

ENDCLASS.
