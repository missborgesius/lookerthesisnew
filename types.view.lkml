view: types {
  sql_table_name: hilary_thesis.types ;;

  dimension: string_field_0 {
    type: string
    sql: ${TABLE}.string_field_0 ;;
  }

  dimension: string_field_1 {
    type: string
    sql: ${TABLE}.string_field_1 ;;
  }

  dimension: string_field_2 {
    type: string
    sql: ${TABLE}.string_field_2 ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
