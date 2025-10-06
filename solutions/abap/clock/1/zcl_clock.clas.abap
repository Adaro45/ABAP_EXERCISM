CLASS zcl_clock DEFINITION
  PUBLIC
  CREATE PUBLIC.

  PUBLIC SECTION.

    METHODS constructor
      IMPORTING
        !hours   TYPE i
        !minutes TYPE i DEFAULT 0.
    METHODS get
      RETURNING
        VALUE(result) TYPE string.
    METHODS add
      IMPORTING
        !minutes TYPE i.
    METHODS sub
      IMPORTING
        !minutes TYPE i.

  PRIVATE SECTION.
    DATA: mv_hours   TYPE i,
          mv_minutes TYPE i.
    METHODS normalize.

ENDCLASS.



CLASS zcl_clock IMPLEMENTATION.

METHOD constructor.
    mv_hours = hours.
    mv_minutes = minutes.
    normalize( ).
  ENDMETHOD.

  METHOD add.
    mv_minutes = mv_minutes + minutes.
    normalize(  ).
  ENDMETHOD.

  METHOD get.
    result = |{ mv_hours WIDTH = 2 ALIGN = RIGHT PAD = '0' }:{ mv_minutes WIDTH = 2 ALIGN = RIGHT PAD = '0' }|.
  ENDMETHOD.

  METHOD sub.
    mv_minutes = mv_minutes - minutes.
    normalize(  ).
  ENDMETHOD.

  METHOD normalize.
    " PASO 1: Convertir minutos excedentes a horas
    " Si tenemos 70 minutos: 70 DIV 60 = 1 hora adicional
    IF mv_minutes >= 60 OR mv_minutes < 0.
      mv_hours = mv_hours + ( mv_minutes DIV 60 ).
      mv_minutes = mv_minutes MOD 60.
    ENDIF.

    " PASO 2: Ajustar minutos negativos
    " Si tenemos -10 minutos: restar 1 hora y convertir a positivo
    IF mv_minutes < 0.
      mv_hours = mv_hours - 1.
      mv_minutes = mv_minutes + 60.
    ENDIF.

    " PASO 3: Normalizar horas al rango 0-23
    " Usar MOD 24 para wrap-around
    mv_hours = mv_hours MOD 24.

    " PASO 4: Ajustar horas negativas
    " Si tenemos -5 horas: 24 - 5 = 19 horas
    IF mv_hours < 0.
      mv_hours = mv_hours + 24.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
