view: keywords {
  sql_table_name: hilary_thesis.keywords ;;

  dimension: string_field_0 {
    type: string
    sql: ${TABLE}.string_field_0 ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
