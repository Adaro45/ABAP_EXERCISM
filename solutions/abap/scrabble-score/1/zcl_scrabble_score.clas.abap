CLASS zcl_scrabble_score DEFINITION PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_scrabble_score IMPLEMENTATION.
  METHOD score.
    DATA: lv_letter TYPE c LENGTH 1,
          lv_points TYPE i.

    " Convertir a mayúsculas para simplificar
    DATA(lv_input_upper) = to_upper( input ).

    " Procesar cada letra
    DO strlen( lv_input_upper ) TIMES.
      DATA(lv_index) = sy-index - 1.
      lv_letter = lv_input_upper+lv_index(1).

      " Asignar puntos según la letra
      CASE lv_letter.
        WHEN 'A' OR 'E' OR 'I' OR 'O' OR 'U' OR 'L' OR 'N' OR 'R' OR 'S' OR 'T'.
          lv_points = 1.
        WHEN 'D' OR 'G'.
          lv_points = 2.
        WHEN 'B' OR 'C' OR 'M' OR 'P'.
          lv_points = 3.
        WHEN 'F' OR 'H' OR 'V' OR 'W' OR 'Y'.
          lv_points = 4.
        WHEN 'K'.
          lv_points = 5.
        WHEN 'J' OR 'X'.
          lv_points = 8.
        WHEN 'Q' OR 'Z'.
          lv_points = 10.
        WHEN OTHERS.
          lv_points = 0.  " Ignorar caracteres no válidos (espacios, números, etc.)
      ENDCASE.

      " Sumar al resultado total
      result = result + lv_points.
    ENDDO.
  ENDMETHOD.

ENDCLASS.
