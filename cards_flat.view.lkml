view: cards_flat {
  sql_table_name: hilary_thesis.cards_flat ;;

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}.id ;;
  }

  dimension: artist {
    type: string
    sql: ${TABLE}.artist ;;
  }

  dimension: border_color {
    type: string
    sql: ${TABLE}.border_color ;;
  }

  dimension: cmc {
    type: number
    sql: ${TABLE}.cmc ;;
  }

  dimension: collector_number {
    type: string
    sql: ${TABLE}.collector_number ;;
  }

  dimension: colors {
    type: string
    sql: ${TABLE}.colors ;;
  }

  dimension: colorshifted {
    type: yesno
    sql: ${TABLE}.colorshifted ;;
  }

  dimension: digital {
    type: yesno
    sql: ${TABLE}.digital ;;
  }

  dimension: eur {
    type: number
    sql: ${TABLE}.eur ;;
  }

  dimension: flavor_text {
    type: string
    sql: ${TABLE}.flavor_text ;;
  }

  dimension: frame {
    type: string
    sql: ${TABLE}.frame ;;
  }

  dimension: futureshifted {
    type: yesno
    sql: ${TABLE}.futureshifted ;;
  }

  dimension: hand_modifier {
    type: number
    sql: ${TABLE}.hand_modifier ;;
  }

  dimension: image_uri {
    type: string
    sql: ${TABLE}.image_uri ;;
  }

  dimension: layout {
    type: string
    sql: ${TABLE}.layout ;;
  }

  dimension: life_modifier {
    type: number
    sql: ${TABLE}.life_modifier ;;
  }

  dimension: loyalty {
    type: string
    sql: ${TABLE}.loyalty ;;
  }

  dimension: mana_cost {
    type: string
    sql: ${TABLE}.mana_cost ;;
  }

  dimension: mtgo_id {
    type: number
    sql: ${TABLE}.mtgo_id ;;
  }

  dimension: multiverse_id {
    type: number
    sql: ${TABLE}.multiverse_id ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: object {
    type: string
    sql: ${TABLE}.object ;;
  }

  dimension: oracle_text {
    type: string
    sql: ${TABLE}.oracle_text ;;
  }

  dimension: power {
    type: string
    sql: ${TABLE}.power ;;
  }

  dimension: rarity {
    type: string
    sql: ${TABLE}.rarity ;;
  }

  dimension: reserved {
    type: yesno
    sql: ${TABLE}.reserved ;;
  }

  dimension: scryfall_set_uri {
    type: string
    sql: ${TABLE}.scryfall_set_uri ;;
  }

  dimension: scryfall_uri {
    type: string
    sql: ${TABLE}.scryfall_uri ;;
  }

  dimension: set_id {
    type: string
    sql: ${TABLE}.set_id ;;
  }

  dimension: set_name {
    type: string
    sql: ${TABLE}.set_name ;;
  }

  dimension: set_uri {
    type: string
    sql: ${TABLE}.set_uri ;;
  }

  dimension: timeshifted {
    type: yesno
    sql: ${TABLE}.timeshifted ;;
  }

  dimension: tix {
    type: number
    sql: ${TABLE}.tix ;;
  }

  dimension: toughness {
    type: string
    sql: ${TABLE}.toughness ;;
  }

  dimension: type_line {
    type: string
    sql: ${TABLE}.type_line ;;
  }

  dimension: uri {
    type: string
    sql: ${TABLE}.uri ;;
  }

  dimension: usd {
    type: number
    sql: ${TABLE}.usd ;;
  }

  dimension: watermark {
    type: string
    sql: ${TABLE}.watermark ;;
  }

  measure: count {
    type: count
    drill_fields: [id, set_name, name]
  }
}
