view: sets {
  sql_table_name: hilary_thesis.sets ;;

  dimension: block {
    type: string
    sql: ${TABLE}.block ;;
  }

  dimension: block_code {
    type: string
    sql: ${TABLE}.block_code ;;
  }

  dimension: card_count {
    type: number
    sql: ${TABLE}.card_count ;;
  }

  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
  }

  dimension: icon_svg_uri {
    type: string
    sql: ${TABLE}.icon_svg_uri ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: object {
    type: string
    sql: ${TABLE}.object ;;
  }

  dimension: parent_set_code {
    type: string
    sql: ${TABLE}.parent_set_code ;;
  }

  dimension_group: released {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.released_at ;;
  }

  dimension: search_uri {
    type: string
    sql: ${TABLE}.search_uri ;;
  }

  dimension: set_type {
    type: string
    sql: ${TABLE}.set_type ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
