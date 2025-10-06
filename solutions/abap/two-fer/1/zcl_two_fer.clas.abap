CLASS zcl_two_fer DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS two_fer
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_two_fer IMPLEMENTATION.

  METHOD two_fer.
  " Si input está vacío o no se proporcionó, usar 'you'
  IF input IS INITIAL.
    result = 'One for you, one for me.'.
  ELSE.
    " Si hay nombre, usar el nombre
    result = |One for { input }, one for me.|.
  ENDIF.
  ENDMETHOD.

ENDCLASS.
