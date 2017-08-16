view: cards_gameplay {
  derived_table: {
    sql_trigger_value: 1 ;;
    sql:SELECT ROW_NUMBER() OVER (ORDER BY cards_flat.name) as id,
               cards_flat.toughness as toughness,
              CASE WHEN toughness LIKE "%*%" OR toughness LIKE "%X%" THEN null
                ELSE CAST(toughness as FLOAT64) END as toughness_int,
                cards_flat.power as power,
                 CASE WHEN power LIKE "%*%" OR power LIKE "%X%" THEN null
                ELSE CAST(power as FLOAT64) END as power_int,
                cards_flat.loyalty as loyalty,
                 CASE WHEN loyalty LIKE "%*%" OR loyalty LIKE "%X%" THEN null
                ELSE CAST(loyalty as FLOAT64) END as loyalty_int,
                cards_flat.cmc as cmc,
                cards_flat.hand_modifier as hand_modifier,
                cards_flat.life_modifier as life_modifier,
                cards_flat.name as card_name,
                cards_flat.type_line as type_line,
                cards_flat.oracle_text as oracle_text,
                cards_flat.layout as layout,
                cards_flat.mana_cost as mana_cost,
                sets.name as set_name,
                sets.released_at as first_release,
                  CASE WHEN type_line LIKE "%Artifact Creature%" THEN "Artifact Creature"
                  WHEN type_line LIKE "%Enchantment Creature%" THEN "Enchantment Creature"
                  WHEN type_line LIKE "%Enchantment%" OR type_line LIKE "%Enchant%" THEN "Enchantment"
                  WHEN type_line LIKE "%Forest%" OR type_line LIKE "%Swamp%" OR type_line LIKE "%Mountain%" OR type_line LIKE "%Plain%" OR type_line LIKE "%Island%" THEN "Basic Land"
                  WHEN type_line LIKE "%Artifact Land" THEN "Artifact Land"
                  WHEN type_line LIKE "%Creature%" OR type_line LIKE "%Summon%" OR type_line LIKE "%Eaturcray%" THEN "Creature"
                  WHEN type_line LIKE "%Artifact%" THEN "Artifact"
                  WHEN type_line LIKE "%Instant%" THEN "Instant"
                  WHEN type_line LIKE "%Land%" THEN "Non-Basic Land"
                 WHEN type_line LIKE "%Planeswalker%" THEN "Planeswalker"
                 WHEN type_line LIKE "%Plane%" THEN "Plane"

                  WHEN type_line LIKE "%Scheme%" THEN "Scheme"
                  WHEN type_Line LIKE "%Sorcery%" THEN "Sorcery"
                  WHEN type_line LIKE "%Conspiracy%" THEN "Conspiracy"
                  WHEN type_line LIKE "%Phenomenon%" THEN "Phenomenon"
                  ELSE null
                  END as card_type
                FROM cards_flat
                JOIN sets on cards_flat.set_id = sets.code
                INNER JOIN (
                    SELECT sets.code, MIN(sets.released_at) as min_date
                    FROM sets
                    GROUP BY code) b ON sets.code = b.code AND released_at = b.min_date
                GROUP BY 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18

        ;;
  }


  dimension: id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: toughness {
    hidden:  yes
    type: string
    sql: ${TABLE}.toughness ;;
  }

  dimension: toughness_int {
    label: " Toughness"
    type: number
    sql: ${TABLE}.toughness_int ;;
  }

  dimension: power {
    hidden: yes
    type: string
    sql: ${TABLE}.power ;;
  }

  dimension: power_int {
    label: "Power"
    type: number
    sql: ${TABLE}.power_int ;;
  }

  dimension: loyalty {
    hidden: yes
    type: number
    sql: ${TABLE}.loyalty ;;
  }

  dimension: loyalty_int {
    label: "Loyalty"
    type: number
    sql: ${TABLE}.loyalty_int ;;
  }

  dimension: cmc {
    label: "Converted Mana Cost"
    type: number
    sql: CAST(${TABLE}.cmc as FLOAT64) ;;
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

  dimension: color_identity {
    type: string
    case: {
      when: {
        sql: REGEXP_CONTAINS(${mana_cost},'({W})') = false
          AND REGEXP_CONTAINS(${mana_cost},'({B})') = false
          AND REGEXP_CONTAINS(${mana_cost},'({U})') = false
          AND REGEXP_CONTAINS(${mana_cost},'({G})') = false
          AND REGEXP_CONTAINS(${mana_cost},'({R})') = false
          OR REGEXP_CONTAINS(${oracle_text},'([Dd]evoid)') = true;;
        label: "Colorless"
      }
      when: {
        sql: REGEXP_CONTAINS(${mana_cost},'({W})') = true
          AND REGEXP_CONTAINS(${mana_cost},'({B})') = false
          AND REGEXP_CONTAINS(${mana_cost},'({U})') = false
          AND REGEXP_CONTAINS(${mana_cost},'({G})') = false
          AND REGEXP_CONTAINS(${mana_cost},'({R})') = false;;
        label: "White"
      }
      when: {
        sql: REGEXP_CONTAINS(${mana_cost},'({R})') = true
          AND REGEXP_CONTAINS(${mana_cost},'({B})') = false
          AND REGEXP_CONTAINS(${mana_cost},'({U})') = false
          AND REGEXP_CONTAINS(${mana_cost},'({G})') = false
          AND REGEXP_CONTAINS(${mana_cost},'({W})') = false;;
        label: "Red"
      }
      when: {
        sql: REGEXP_CONTAINS(${mana_cost},'({G})') = true
          AND REGEXP_CONTAINS(${mana_cost},'({B})') = false
          AND REGEXP_CONTAINS(${mana_cost},'({U})') = false
          AND REGEXP_CONTAINS(${mana_cost},'({W})') = false
          AND REGEXP_CONTAINS(${mana_cost},'({R})') = false;;
        label: "Green"
      }
      when: {
        sql: REGEXP_CONTAINS(${mana_cost},'({U})') = true
          AND REGEXP_CONTAINS(${mana_cost},'({B})') = false
          AND REGEXP_CONTAINS(${mana_cost},'({W})') = false
          AND REGEXP_CONTAINS(${mana_cost},'({G})') = false
          AND REGEXP_CONTAINS(${mana_cost},'({R})') = false;;
        label: "Blue"
      }
      when: {
        sql: REGEXP_CONTAINS(${mana_cost},'({B})') = true
          AND REGEXP_CONTAINS(${mana_cost},'({W})') = false
          AND REGEXP_CONTAINS(${mana_cost},'({U})') = false
          AND REGEXP_CONTAINS(${mana_cost},'({G})') = false
          AND REGEXP_CONTAINS(${mana_cost},'({R})') = false;;
        label: "Black"
      }
     else: "Multi"

    }
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
    sql: ${TABLE}.first_release ;;
  }

  dimension: supertype {
    type: string
    case: {
      when: {
        sql: ${type_line} LIKE "%Snow%" ;;
        label: "Snow"
      }
      when: {
        sql: ${type_line} LIKE "%Legendary%" ;;
        label: "Legendary"
      }
      when: {
        sql: ${type_line} LIKE "%Tribal%" ;;
        label: "Tribal"
      }
      when: {
        sql: ${type_line} LIKE "%World%" ;;
        label: "World"
      }
    }
    }

 dimension: type {
   type: string
  sql: ${TABLE}.card_type ;;
 }

  measure: count {
    type: count
    drill_fields: [name, oracle_text,type_line]
  }

  }
