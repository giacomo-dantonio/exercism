CLASS zcl_resistor_color DEFINITION PUBLIC CREATE PUBLIC.
  PUBLIC SECTION.
    CLASS-METHODS class_constructor.
  
    METHODS resistor_color
      IMPORTING
        color_code   TYPE string
      RETURNING
        VALUE(value) TYPE i.

  PRIVATE SECTION.
    CLASS-DATA gt_colors TYPE STANDARD TABLE OF string WITH EMPTY KEY.
ENDCLASS.

CLASS zcl_resistor_color IMPLEMENTATION.
  METHOD class_constructor.
    gt_colors = VALUE #(
      ( 'black' )
      ( 'brown' )
      ( 'red' )
      ( 'orange' )
      ( 'yellow' )
      ( 'green' )
      ( 'blue' )
      ( 'violet' )
      ( 'grey' )
      ( 'white' )
    ).
  ENDMETHOD.
  
  METHOD resistor_color.
    value = line_index(
      gt_colors[ table_line = to_lower( color_code ) ]
    ) - 1.
  ENDMETHOD.

ENDCLASS.
