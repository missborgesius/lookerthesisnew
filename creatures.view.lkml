view: creatures {
  derived_table: {
    sql: SELECT ${cards_gameplay.SQL_TABLE_NAME}.card_name as card_name,
                oracle_text,
                type_line,
                subtypes.name as subtype,
                keywords.string_field_0 as keyword
FROM `hilary-thesis.looker_scratch.LR_2S7IXGJDOEO2U9M5DK4O_cards_gameplay`
JOIN subtypes ON LOWER(type_line) LIKE CONCAT("%"," ",subtypes.name,"%")
JOIN keywords ON LOWER(oracle_text) LIKE CONCAT("%",keywords.string_field_0,"%")
where type_line LIKE "Creature %" ;;
  }

  dimension: card_name {
    hidden: yes
    type: string
    sql: ${TABLE}.card_name ;;
  }

  dimension: oracle_text {
    hidden: yes
    type: string
    sql: ${TABLE}.oracle_text ;;
  }


  dimension: subtype {
    type: string
    sql: ${TABLE}.subtype ;;
  }

  dimension: keyword {
    type: string
    sql: ${TABLE}.keyword ;;
  }


  dimension: keyword_action{
    case: {
      when: {
        sql: REGEXP_MATCH(${oracle_text},'( have {{creatures.keyword._value}} )')  ;;
      }
    }

  }
  }
