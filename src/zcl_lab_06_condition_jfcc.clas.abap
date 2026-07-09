CLASS zcl_lab_06_condition_jfcc DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_lab_06_condition_jfcc IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

* DO/ENDDO

DATA lv_counter TYPE i.

DO 10 TIMES.

  lv_counter += 1.

  out->write(
    |Iteración { sy-index } - Contador = { lv_counter }|
  ).

ENDDO.

* CHECK

CLEAR lv_counter.

DO 10 TIMES.

  lv_counter += 1.

  CHECK lv_counter <= 7.

  out->write(
    |Contador = { lv_counter }|
  ).

ENDDO.

* SWITCH

DATA lv_string_2 TYPE string.
DATA lv_result   TYPE string.

lv_string_2 = 'LOGALI'.

lv_result = SWITCH string(
  lv_string_2
  WHEN 'LOGALI'   THEN 'SAP Academy'
  WHEN 'SAP'      THEN 'Enterprise software'
  WHEN 'MOVISTAR' THEN 'Telephony'
  ELSE 'Unknown'
).

out->write( lv_result ).

lv_string_2 = 'SAP'.

lv_result = SWITCH string(
  lv_string_2
  WHEN 'LOGALI'   THEN 'SAP Academy'
  WHEN 'SAP'      THEN 'Enterprise software'
  WHEN 'MOVISTAR' THEN 'Telephony'
  ELSE 'Unknown'
).

out->write( lv_result ).

* COND

DATA lv_time TYPE t.

lv_time = cl_abap_context_info=>get_system_time( ).

DATA(lv_period) =
    COND string(

      WHEN lv_time < '120000'
        THEN 'AM'

      WHEN lv_time = '120000'
        THEN 'HIGH NOON'

      ELSE
        'PM'

    ).

out->write(
    |Hora: { lv_time } { lv_period }|
).

* WHILE
" Primero hasta 20

DATA lv_counter_2 TYPE i.

WHILE lv_counter_2 < 20.

  lv_counter_2 += 1.

  out->write(
    |{ lv_counter_2 }|
  ).

ENDWHILE.

"Hasta 10 sin usar EXIT

 CLEAR lv_counter_2.

WHILE lv_counter_2 < 10.

  lv_counter_2 += 1.

  out->write(
    |{ lv_counter_2 }|
  ).

ENDWHILE.

* LOOP

*DATA:
*
*  lt_employees TYPE TABLE OF zemp_logali,
*  ls_employees  TYPE zemp_logali.
*
*SELECT *
*  FROM zemp_logali
*  INTO TABLE @lt_employees.
*
*LOOP AT lt_employees INTO ls_employee
*     WHERE ape2 = 'JIMENEZ'.
*
*  out->write(
*    ls_employee-email
*  ).
*
*ENDLOOP.

* TRY/CATCH

DATA lv_exception TYPE f VALUE '5'.

DO 5 TIMES.

  lv_counter = 5.

  lv_counter = lv_counter - sy-index + 1.

  TRY.

      DATA(lv_result2) =
          lv_exception / lv_counter.

      out->write(
        |Resultado = { lv_result2 }|
      ).

    CATCH cx_sy_zerodivide.

      out->write(
        'División por cero.'
      ).

  ENDTRY.

ENDDO.

  ENDMETHOD.

ENDCLASS.
