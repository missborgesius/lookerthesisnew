view: behavior {
  sql_table_name: hilary_thesis.behavior ;;

  dimension: primary_key {
    type: string
    sql: CONCAT(${behavior},${name}) ;;
    primary_key: yes
    hidden: yes
  }

  dimension: behavior {
    type: string
    sql: ${TABLE}.behavior ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [behavior]
  }
}
