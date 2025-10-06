CLASS zcl_high_scores DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS constructor
      IMPORTING
        scores TYPE integertab.

    METHODS list_scores
      RETURNING
        VALUE(result) TYPE integertab.

    METHODS latest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personalbest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personaltopthree
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA scores_list TYPE integertab.

ENDCLASS.


CLASS zcl_high_scores IMPLEMENTATION.

  METHOD constructor.
    me->scores_list = scores.
  ENDMETHOD.

  METHOD list_scores.
    result = me->scores_list.
  ENDMETHOD.

  METHOD latest.
        DATA(lv_lines) = lines( me->scores_list ).

    IF lv_lines > 0.
      result = me->scores_list[ lv_lines ].
    ENDIF.
  ENDMETHOD.

  METHOD personalbest.
        IF lines( me->scores_list ) > 0.
      " Copiar y ordenar descendente
      DATA(lt_sorted) = me->scores_list.
      SORT lt_sorted DESCENDING.

      " La primera es la más alta
      result = lt_sorted[ 1 ].
    ENDIF.
  ENDMETHOD.

  METHOD personaltopthree.
        DATA(lt_sorted) = me->scores_list.
    SORT lt_sorted DESCENDING.

    " Tomar máximo 3 elementos
    DATA(lv_max) = COND i( WHEN lines( lt_sorted ) < 3
                           THEN lines( lt_sorted )
                           ELSE 3 ).

    " Construir resultado con las primeras lv_max puntuaciones
    DO lv_max TIMES.
      APPEND lt_sorted[ sy-index ] TO result.
    ENDDO.
  ENDMETHOD.


ENDCLASS.
