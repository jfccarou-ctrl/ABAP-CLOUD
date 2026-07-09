CLASS zcl_lab_05_invoice_jfccv2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lab_05_invoice_jfccv2 IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*--------------------------------------------------------------------
* 1. OVERLAY
*--------------------------------------------------------------------
    DATA:
      lv_sale        TYPE string VALUE 'Purchase Completed',
      lv_sale_status TYPE string VALUE 'Invoice'.

    out->write( '==================== 1. OVERLAY ====================' ).
    out->write( |Antes: { lv_sale }| ).

    OVERLAY lv_sale WITH lv_sale_status.

    out->write( |Después: { lv_sale }| ).

*--------------------------------------------------------------------
* 2. SUBSTRING
*--------------------------------------------------------------------
    DATA: lv_result TYPE string VALUE 'SAP-ABAP-32-PE',
          lv_before TYPE string,
          lv_after  TYPE string.

    out->write( '==================== 2. SUBSTRING ==================' ).
    out->write( |Cadena original: { lv_result }| ).

* Posiciones 9 a 14 (offset 8, longitud 6)
    lv_result = substring(
                  val = lv_result
                  off = 8
                  len = 6 ).

    out->write( |Substring: { lv_result }| ).

* Antes y después de "ABAP"
    lv_before = substring(
                  val = 'SAP-ABAP-32-PE'
                  off = 0
                  len = 4 ).

    lv_after = substring(
                 val = 'SAP-ABAP-32-PE'
                 off = 8 ).

    out->write( |Antes de ABAP: { lv_before }| ).
    out->write( |Después de ABAP: { lv_after }| ).

*--------------------------------------------------------------------
* 3. FIND
*--------------------------------------------------------------------
    DATA:
      lv_status TYPE string VALUE 'INVOICE GENERATED SUCCESSFULLY',
      lv_count  TYPE i,
      lv_pos    TYPE i.

    out->write( '====================== 3. FIND ======================' ).

    FIND FIRST OCCURRENCE OF REGEX 'GEN' IN lv_status MATCH OFFSET lv_pos.

    out->write( |Primera aparición de G, E o N: posición { lv_pos }| ).

    lv_count = count(
                 val = lv_status
                 sub = 'A' ).

    out->write( |Cantidad de letras A: { lv_count }| ).

*--------------------------------------------------------------------
* 4. REPLACE
*--------------------------------------------------------------------
    DATA lv_request TYPE string VALUE 'SAP-ABAP-32-PE'.

    out->write( '==================== 4. REPLACE =====================' ).
    out->write( |Antes: { lv_request }| ).

    REPLACE ALL OCCURRENCES OF '-'
      IN lv_request
      WITH '/'.

    out->write( |Después: { lv_request }| ).

*--------------------------------------------------------------------
* 5. PCRE REGEX
*--------------------------------------------------------------------
    DATA:
      lv_regex TYPE string VALUE '^[_a-z0-9-]+(\.[_a-z0-9-]+)*@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})$',
      lv_email TYPE string VALUE 'usuario@gmail.com'.

    out->write( '==================== 5. REGEX =======================' ).

    FIND REGEX lv_regex
      IN lv_email.

    IF sy-subrc = 0.
      out->write( |Correo válido: { lv_email }| ).
    ELSE.
      out->write( |Correo NO válido: { lv_email }| ).
    ENDIF.

*--------------------------------------------------------------------
* 6. EXPRESIONES REGULARES
*--------------------------------------------------------------------
    DATA lv_idcustome TYPE string VALUE '0000012345'.

    out->write( '=============== 6. EXPRESIONES REGULARES ============' ).
    out->write( |Antes: { lv_idcustome }| ).

    lv_regex = '^0+'.

    REPLACE FIRST OCCURRENCE OF REGEX lv_regex
      IN lv_idcustome
      WITH ''.

    out->write( |Después: { lv_idcustome }| ).

*--------------------------------------------------------------------
* 7. REPEAT
*--------------------------------------------------------------------
    out->write( '===================== 7. REPEAT =====================' ).

    lv_idcustome = repeat(
                     val = lv_idcustome
                     occ = 3 ).

    out->write( |Resultado: { lv_idcustome }| ).

*--------------------------------------------------------------------
* 8. ESCAPE
*--------------------------------------------------------------------
    DATA lv_format TYPE string VALUE 'Send payment data via Internet'.

    out->write( '===================== 8. ESCAPE =====================' ).

    out->write(
      |URL: { escape(
                 val    = lv_format
                 format = cl_abap_format=>e_url ) }| ).

    out->write(
      |JSON: { escape(
                  val    = lv_format
                  format = cl_abap_format=>e_json_string ) }| ).

    out->write(
      |String Template: { escape(
                             val    = lv_format
                             format = cl_abap_format=>e_string_tpl ) }| ).

  ENDMETHOD.

ENDCLASS.
