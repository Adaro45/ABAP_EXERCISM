CLASS zcl_nth_prime DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
   
    METHODS prime
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE i
      RAISING
        cx_parameter_invalid.
        
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS is_prime
      IMPORTING
        number        TYPE i
      RETURNING
        VALUE(result) TYPE abap_bool.
ENDCLASS.

CLASS zcl_nth_prime IMPLEMENTATION.
  METHOD prime.
    " PASO 1: Validar entrada
    IF input < 1.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    " PASO 2: Buscar el n-ésimo primo
    DATA lv_count  TYPE i VALUE 0.      " Contador de primos encontrados
    DATA lv_candidate  TYPE i VALUE 2.  " Candidato actual (empezar desde 2)

    WHILE lv_count < input.
      " Verificar si el candidato es primo
      IF is_prime( lv_candidate ) = abap_true.
        lv_count = lv_count + 1.

        " Si ya encontramos el n-ésimo primo, guardarlo
        IF lv_count = input.
          result = lv_candidate.
        ENDIF.
      ENDIF.

      " Siguiente candidato
      lv_candidate = lv_candidate + 1.
    ENDWHILE.
  ENDMETHOD.

  METHOD is_prime.
    " Verificar si un número es primo

    " CASO 1: Números <= 1 no son primos
    IF number <= 1.
      result = abap_false.
      RETURN.
    ENDIF.

    " CASO 2: 2 es primo (único primo par)
    IF number = 2.
      result = abap_true.
      RETURN.
    ENDIF.

    " CASO 3: Números pares no son primos
    IF number MOD 2 = 0.
      result = abap_false.
      RETURN.
    ENDIF.

    " CASO 4: Verificar divisibilidad desde 3 hasta √n
    DATA(lv_limit) = sqrt( number ).

    DATA lv_divisor  TYPE i VALUE 3.
    WHILE lv_divisor <= lv_limit.
      IF number MOD lv_divisor = 0.
        " Encontramos un divisor, no es primo
        result = abap_false.
        RETURN.
      ENDIF.

      " Siguiente divisor impar (saltar pares)
      lv_divisor = lv_divisor + 2.
    ENDWHILE.

    " Si llegamos aquí, es primo
    result = abap_true.
  ENDMETHOD.

ENDCLASS.
