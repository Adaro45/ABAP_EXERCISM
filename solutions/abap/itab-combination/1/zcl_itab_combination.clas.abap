CLASS zcl_itab_combination DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF alphatab_type,
             cola TYPE string,
             colb TYPE string,
             colc TYPE string,
           END OF alphatab_type.
    TYPES alphas TYPE STANDARD TABLE OF alphatab_type.

    TYPES: BEGIN OF numtab_type,
             col1 TYPE string,
             col2 TYPE string,
             col3 TYPE string,
           END OF numtab_type.
    TYPES nums TYPE STANDARD TABLE OF numtab_type.

    TYPES: BEGIN OF combined_data_type,
             colx TYPE string,
             coly TYPE string,
             colz TYPE string,
           END OF combined_data_type.
    TYPES combined_data TYPE STANDARD TABLE OF combined_data_type WITH EMPTY KEY.

    METHODS perform_combination
      IMPORTING
        alphas             TYPE alphas
        nums               TYPE nums
      RETURNING
        VALUE(combined_data) TYPE combined_data.

  PROTECTED SECTION.
  PRIVATE SECTION.


ENDCLASS.

CLASS zcl_itab_combination IMPLEMENTATION.

  METHOD perform_combination.
DATA: lt_result TYPE combined_data,

          ls_result TYPE combined_data_type.

    " Procesar fila por fila
    LOOP AT alphas INTO DATA(ls_alpha).
      DATA(lv_index) = sy-tabix.  " Guardar índice actual

      " Leer la fila correspondiente de NUMS
      READ TABLE nums INTO DATA(ls_num) INDEX lv_index.
      IF sy-subrc = 0.
        " Combinar las tres columnas
        ls_result-colx = |{ ls_alpha-cola }{ ls_num-col1 }|.
        ls_result-coly = |{ ls_alpha-colb }{ ls_num-col2 }|.
        ls_result-colz = |{ ls_alpha-colc }{ ls_num-col3 }|.

        APPEND ls_result TO lt_result.
      ENDIF.
    ENDLOOP.

    combined_data = lt_result.
  ENDMETHOD.

ENDCLASS.
