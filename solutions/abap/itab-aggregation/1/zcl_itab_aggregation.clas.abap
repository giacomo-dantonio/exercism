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
    DATA: lv_sum TYPE i,
          lv_min   TYPE i,
          lv_max   TYPE i,
          lv_avg   TYPE f.

    LOOP AT initial_numbers INTO DATA(ls_initial_number)
      GROUP BY ( group = ls_initial_number-group count = GROUP SIZE )
      INTO DATA(ls_group).

      lv_sum = 0.
      lv_min = 999999999.
      lv_max = -999999999.

      LOOP AT GROUP ls_group INTO DATA(ls_group_item).
        lv_sum = lv_sum + ls_group_item-number.
        lv_min = nmin( val1 = lv_min val2 = ls_group_item-number ).
        lv_max = nmax( val1 = lv_max val2 = ls_group_item-number ).
      ENDLOOP.

      lv_avg = lv_sum / ls_group-count.

      APPEND VALUE #(
        group = ls_group-group
        count = ls_group-count
        sum = lv_sum
        min = lv_min
        max = lv_max
        average = lv_avg
      ) TO aggregated_data.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
