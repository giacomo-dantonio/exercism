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
    DATA n TYPE i.

    DESCRIBE TABLE me->scores_list LINES n.
    READ TABLE me->scores_list INDEX n INTO result.
  ENDMETHOD.

  METHOD personalbest.
    DATA(sorted_scores) = me->scores_list.
    SORT sorted_scores DESCENDING.

    READ TABLE sorted_scores INDEX 1 INTO result.
  ENDMETHOD.

  METHOD personaltopthree.
    DATA n TYPE i.
    DATA(sorted_scores) = me->scores_list.
    SORT sorted_scores DESCENDING.

    DESCRIBE TABLE sorted_scores LINES n.
    n = nmin( val1 = n val2 = 3 ).
    DO n TIMES.
      READ TABLE sorted_scores INDEX sy-index INTO DATA(value).
      APPEND value TO result.
    ENDDO.
  ENDMETHOD.


ENDCLASS.
