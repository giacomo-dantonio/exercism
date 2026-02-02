CLASS zcl_scrabble_score DEFINITION PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
        
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-METHODS char_score
      IMPORTING
        input         TYPE c
      RETURNING
        VALUE(result) TYPE i.

ENDCLASS.


CLASS zcl_scrabble_score IMPLEMENTATION.
  METHOD score.
    DATA: char   TYPE c LENGTH 1,
          offset TYPE i.
  
    result = 0.
    
    DO STRLEN( input ) TIMES.
      offset = sy-index - 1.
      char = input+offset(1).
      result = result + zcl_scrabble_score=>char_score( char ).
    ENDDO.
  ENDMETHOD.

  METHOD char_score.
    CASE to_upper( input ).
      WHEN 'A' OR 'E' OR 'I' OR 'O' OR 'U' OR 'L' OR 'N' OR 'R' OR 'S' OR 'T'.
        result = 1.
      WHEN 'D' OR 'G'.
        result = 2.
      WHEN 'B' OR 'C' OR 'M' OR 'P'.
        result = 3.
      WHEN 'F' OR 'H' OR 'V' OR 'W' OR 'Y'.
        result = 4.
      WHEN 'K'.
        result = 5.
      WHEN 'J' OR 'X'.
        result = 8.
      WHEN 'Q' OR 'Z'.
        result = 10.
      WHEN OTHERS.
        result = 0.
    ENDCASE.
  ENDMETHOD.
ENDCLASS.
