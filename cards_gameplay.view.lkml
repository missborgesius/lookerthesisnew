view: cards_gameplay {
  derived_table: {
    sql_trigger_value: 1 ;;
    sql:SELECT ROW_NUMBER() OVER (ORDER BY cards_flat.name) as id,
               cards_flat.toughness as toughness,
                cards_flat.power as power,
                cards_flat.loyalty as loyalty,
                cards_flat.cmc as cmc,
                cards_flat.hand_modifier as hand_modifier,
                cards_flat.life_modifier as life_modifier,
                cards_flat.name as card_name,
                cards_flat.type_line as type_line,
                cards_flat.oracle_text as oracle_text,
                cards_flat.mana_cost as mana_cost,
                cards_flat.layout as layout,
                sets.name as set_name,
                sets.released_at as first_release
                FROM cards_flat
                JOIN sets on cards_flat.set_id = sets.code
                INNER JOIN (
                    SELECT sets.code, MIN(sets.released_at) as min_date
                    FROM sets
                    GROUP BY code) b ON sets.code = b.code AND released_at = b.min_date
                GROUP BY 2,3,4,5,6,7,8,9,10,11,12,13,14
        ;;
  }

  dimension: id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: toughness {
    type: number
    sql: ${TABLE}.toughness ;;
  }

  dimension: power {
    type: number
    sql: ${TABLE}.power ;;
  }

  dimension: loyalty {
    type: number
    sql: ${TABLE}.loyalty ;;
  }

  dimension: cmc {
    label: "Converted Mana Cost"
    type: number
    sql: ${TABLE}.cmc ;;
  }
#
#   dimension: hand_modifier {
#     type: number
#     sql: ${TABLE}.hand_modifier ;;
#   }
#
#   dimension: life_modifier {
#     type: number
#     sql: ${TABLE}.life_modifier ;;
#   }

  dimension: name {
    type: string
    sql: ${TABLE}.card_name ;;
  }

  dimension: type_line {
    type: string
    sql: ${TABLE}.type_line ;;
  }

  dimension: oracle_text {
    type: string
    sql: ${TABLE}.oracle_text ;;
  }

  dimension: mana_cost {
    type: string
    sql: ${TABLE}.mana_cost ;;
  }

#   dimension: layout {
#     type: string
#     sql: ${TABLE}.layout ;;
#   }

  dimension: set_name {
    type: string
    sql: ${TABLE}.set_name ;;
  }

  dimension_group: first_release {
    type: time
    timeframes: [year, date, month]
    sql: ${TABLE}.first_released ;;
  }

  dimension: type{
    type: string
    sql: REGEXP_EXTRACT(${type_line},'^([A-Za-z]* ) [—$]');;
  }

  measure: count {
    type: count
    drill_fields: [name, oracle_text]
  }

  }
