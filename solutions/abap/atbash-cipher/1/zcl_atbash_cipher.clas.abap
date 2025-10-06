CLASS zcl_atbash_cipher DEFINITION PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS decode
      IMPORTING
        cipher_text TYPE string
      RETURNING
        VALUE(plain_text)  TYPE string .
    METHODS encode
      IMPORTING
        plain_text        TYPE string
      RETURNING
        VALUE(cipher_text) TYPE string .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_atbash_cipher IMPLEMENTATION.
  METHOD decode.
    DATA: char TYPE c LENGTH 1,
          pos TYPE i,
          decoded_char TYPE c LENGTH 1,
          temp_text TYPE string,
          len TYPE i,
          offset TYPE i.

    " Remover espacios del texto cifrado
    temp_text = cipher_text.
    REPLACE ALL OCCURRENCES OF ` ` IN temp_text WITH ||.

    " Convertir a minúsculas
    temp_text = to_lower( temp_text ).

    len = strlen( temp_text ).

    " Procesar cada carácter
    DO len TIMES.
      offset = sy-index - 1.
      char = temp_text+offset(1).

      " Si es una letra, aplicar Atbash
      IF char >= 'a' AND char <= 'z'.
        " Calcular posición en el alfabeto (0-25)
        FIND char IN 'abcdefghijklmnopqrstuvwxyz' MATCH OFFSET pos.

        " Aplicar transformación Atbash: posición invertida
        decoded_char = substring( val = 'zyxwvutsrqponmlkjihgfedcba' off = pos len = 1 ).
        plain_text = |{ plain_text }{ decoded_char }|.
      ELSEIF char >= '0' AND char <= '9'.
        " Los números se mantienen sin cambios
        plain_text = |{ plain_text }{ char }|.
      ENDIF.
    ENDDO.

  ENDMETHOD.

  METHOD encode.
    DATA: char TYPE c LENGTH 1,
          pos TYPE i,
          encoded_char TYPE c LENGTH 1,
          temp_text TYPE string,
          counter TYPE i VALUE 0,
          len TYPE i,
          offset TYPE i.

    " Convertir a minúsculas
    temp_text = to_lower( plain_text ).

    len = strlen( temp_text ).

    " Procesar cada carácter
    DO len TIMES.
      offset = sy-index - 1.
      char = temp_text+offset(1).

      " Si es una letra, aplicar Atbash
      IF char >= 'a' AND char <= 'z'.
        " Calcular posición en el alfabeto (0-25)
        FIND char IN 'abcdefghijklmnopqrstuvwxyz' MATCH OFFSET pos.

        " Aplicar transformación Atbash: posición invertida
        encoded_char = substring( val = 'zyxwvutsrqponmlkjihgfedcba' off = pos len = 1 ).

        " Agregar espacio cada 5 caracteres
        IF counter = 5.
          cipher_text = |{ cipher_text } |.
          counter = 0.
        ENDIF.

        cipher_text = |{ cipher_text }{ encoded_char }|.
        counter = counter + 1.

      ELSEIF char >= '0' AND char <= '9'.
        " Los números se mantienen sin cambios
        IF counter = 5.
          cipher_text = |{ cipher_text } |.
          counter = 0.
        ENDIF.

        cipher_text = |{ cipher_text }{ char }|.
        counter = counter + 1.
      ENDIF.
      " Ignorar todo lo demás (espacios, puntuación, etc.)
    ENDDO.

  ENDMETHOD.
ENDCLASS.
