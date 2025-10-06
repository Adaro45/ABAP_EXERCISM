CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_itab_aggregation IMPLEMENTATION.
  METHOD perform_aggregation.
        DATA: lt_result TYPE aggregated_data,
          ls_agg    TYPE aggregated_data_type.

    " PASO 1: ORDENAR por grupo
    " Esto agrupa todos los registros del mismo grupo juntos

    DATA(lt_sorted) = initial_numbers.
    SORT lt_sorted BY group.

    " PASO 2: Variables de control
    " lv_current_group: Recordar qué grupo estamos procesando

    DATA: lv_current_group  TYPE group VALUE space,
          lv_first_in_group TYPE abap_bool.

    " PASO 3: Procesar cada registro UNA SOLA VEZ

    LOOP AT lt_sorted INTO DATA(ls_number).

      " Si cambiamos de grupo, guardar el anterior y empezar nuevo

      IF ls_number-group <> lv_current_group.
        " Guardar grupo anterior si existe

        IF lv_current_group IS NOT INITIAL.
          ls_agg-average = ls_agg-sum / ls_agg-count.
          APPEND ls_agg TO lt_result.
        ENDIF.

        " Inicializar nuevo grupo

        CLEAR ls_agg.
        ls_agg-group = ls_number-group.
        ls_agg-min = ls_number-number.
        ls_agg-max = ls_number-number.
        lv_current_group = ls_number-group.
      ENDIF.

      " Actualizar agregaciones
      ls_agg-count = ls_agg-count + 1.
      ls_agg-sum = ls_agg-sum + ls_number-number.

      IF ls_number-number < ls_agg-min.
        ls_agg-min = ls_number-number.
      ENDIF.

      IF ls_number-number > ls_agg-max.
        ls_agg-max = ls_number-number.
      ENDIF.

    ENDLOOP.

    " No olvidar el último grupo
    IF lv_current_group IS NOT INITIAL.
      ls_agg-average = ls_agg-sum / ls_agg-count.
      APPEND ls_agg TO lt_result.
    ENDIF.

    aggregated_data = lt_result.
  ENDMETHOD.

ENDCLASS.
