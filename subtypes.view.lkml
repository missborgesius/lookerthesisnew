view: subtypes {
  sql_table_name: hilary_thesis.subtypes ;;

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: tribal {
    type: yesno
    sql: ${TABLE}.tribal ;;
  }

  dimension: type_dependency {
    type: string
    sql: ${TABLE}.type_dependency ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}

view: subtypes_cards {
  derived_table: {
    sql: SELECT cards_clean.name as card_name, subtypes.name as subtype_name, subtypes_tribal as tribal
    FROM cards_clean
    JOIN subtypes ON LOWER(cards_clean.type_line) LIKE(CONCAT("%"," ","subtypes_name"," ","%");;
  }

  dimension: primary_key {
    hidden: yes
    type: string
    primary_key: yes
    sql: CONCAT(${card_name},${subtype}) ;;
  }

  dimension: card_name {
    hidden: yes
    type: string
    sql: ${TABLE}.card_name ;;
  }

  dimension: subtype {
    type: string
    sql: ${TABLE}.subtype_name ;;
  }

  dimension: tribal {
    type: yesno
    sql: ${TABLE}.tribal ;;
  }

  measure: count {
    type: count
    drill_fields: [subtype]
  }
}
