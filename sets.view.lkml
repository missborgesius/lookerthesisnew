view: sets {
  sql_table_name: hilary_thesis.sets ;;

  dimension: block {
    type: string
    sql: ${TABLE}.block ;;
  }

  dimension: block_code {
    hidden: yes
    type: string
    sql: ${TABLE}.block_code ;;
  }

  dimension: card_count {
    type: number
    sql: ${TABLE}.card_count ;;
    hidden: yes
  }

  dimension: code {
    type: string
    sql: ${TABLE}.code ;;
    primary_key: yes
  }

  dimension: set_symbol {
    html: <img src="{{value}}" width="100" height="100"/> ;;
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
    hidden: yes
  }

  dimension_group: released {
    type: time
    timeframes: [
      date,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.released_at ;;
  }

  dimension: search_uri {
    type: string
    sql: ${TABLE}.search_uri ;;
    hidden: yes
  }

  dimension: set_type {
    type: string
    sql: ${TABLE}.set_type ;;
    hidden: yes
  }



  measure: count {
    type: count
    drill_fields: [name]
  }
}
