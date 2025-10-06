CLASS zcl_hamming DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS hamming_distance
      IMPORTING
        first_strand  TYPE string
        second_strand TYPE string
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.
ENDCLASS.

CLASS zcl_hamming IMPLEMENTATION.

  METHOD hamming_distance.
    " PASO 1: Validar que las cadenas tengan la misma longitud
    IF strlen( first_strand ) <> strlen( second_strand ).
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.
    " PASO 2: Inicializar variables de control
    DATA(lv_length) = strlen( first_strand ).
    DATA lv_distance TYPE i VALUE 0.

    " PASO 3: Comparar carácter por carácter
    DO lv_length TIMES.
      DATA(lv_index) = sy-index - 1.  " Índice base 0

      " Obtener caracteres en la posición actual
      DATA(lv_char1) = first_strand+lv_index(1).
      DATA(lv_char2) = second_strand+lv_index(1).

      " Si son diferentes, incrementar contador
      IF lv_char1 <> lv_char2.
        lv_distance = lv_distance + 1.
      ENDIF.
    ENDDO.
    result = lv_distance.
  ENDMETHOD.

ENDCLASS.
