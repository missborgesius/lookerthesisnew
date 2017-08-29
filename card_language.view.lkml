view: card_language {
  derived_table: {
    sql: SELECT card_name as card_name, oracle_text as oracle_text FROM ${cards_gameplay.SQL_TABLE_NAME}
    group by 1,2;;
  }

  dimension: card_name {
    type: string
    hidden: yes
    primary_key: yes
    sql: ${TABLE}.card_name ;;
  }

  dimension: oracle_text {
    type: string
    hidden: yes
    sql: ${TABLE}.oracle_text ;;
  }

  dimension: target_card {
    type: yesno
    sql: REGEXP_CONTAINS(LOWER(${oracle_text}),'target') ;;
  }

  dimension: state_dependent {
    type: yesno
    sql: REGEXP_CONTAINS(LOWER(${oracle_text}),'equal to') ;;
  }

  dimension: activated_ability {
    type: yesno
    sql: REGEXP_CONTAINS(${oracle_text},'{[A-Z0-9]*}') ;;
  }

  dimension: text_length {
    type: number
    sql: LENGTH(${oracle_text}) ;;
  }


  measure: max_length {
    type: max
    sql: ${text_length} ;;
    drill_fields: [card_name,oracle_text]
  }

  measure: min_length {
    type: min
    sql: ${text_length} ;;
    drill_fields: [card_name,oracle_text]
  }

  measure: avg_length {
    type: average
    sql: ${text_length} ;;
    drill_fields: [card_name,oracle_text]
  }

  measure: count_notext {
    type: count
    filters: {
      field: oracle_text
      value: "null"
    }
    drill_fields: [card_name,oracle_text]
  }

  measure: count_target {
    type: count
    filters: {
      field: target_card
      value: "Yes"
    }
    drill_fields: [card_name,oracle_text]
  }


  measure: count_state_dependent {
    type: count
    filters: {
      field: state_dependent
      value: "Yes"
    }
    drill_fields: [card_name,oracle_text]
  }

  measure: count_activated_ability{
    type: count
    filters: {
      field: activated_ability
      value: "Yes"
    }
    drill_fields: [card_name,oracle_text]
  }


}
