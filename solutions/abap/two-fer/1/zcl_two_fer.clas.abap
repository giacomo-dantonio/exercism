CLASS zcl_two_fer DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS two_fer
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE string.
ENDCLASS.

CLASS zcl_two_fer IMPLEMENTATION.

  METHOD two_fer.
    DATA name TYPE string.

    IF input is INITIAL.
      name = 'you'.
    ELSE.
      name = input.
    ENDIF.

    result = |One for { name }, one for me.|.
  ENDMETHOD.

ENDCLASS.
