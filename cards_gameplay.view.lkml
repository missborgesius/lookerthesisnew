view: cards_gameplay {
  derived_table: {
    sql_trigger_value: 1 ;;
    sql:-- raw sql results do not include filled-in values for 'cards_gameplay.has_text'


-- generate derived table cards_gameplay
-- running the following sql through the bigquery API to create table as select:
-- Building mtg_thesis::cards_gameplay in dev mode on instance 353ba745759ae06280e04aa875a6da88
SELECT ROW_NUMBER() OVER (ORDER BY cards_flat.name) as id,
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
                  END as card_type,
                CASE WHEN toughness LIKE "%*%" OR toughness LIKE "%X%" THEN "Variable"
                WHEN power LIKE "%*%" OR power LIKE "%X%" THEN "Variable"
                ELSE CAST(CAST(power as FLOAT64)+CAST(toughness as FLOAT64) as STRING) END AS power_toughness_sum
                FROM cards_flat
                JOIN sets on cards_flat.set_id = sets.code
                INNER JOIN (
                    SELECT sets.code, MIN(sets.released_at) as min_date
                    FROM sets
                    GROUP BY code) b ON sets.code = b.code AND released_at = b.min_date
                GROUP BY 2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19


        ;;
  }


  dimension: id {
    type: number
    primary_key: yes

    sql: ${TABLE}.id ;;
  }

  dimension: toughness {

    type: string
    sql: ${TABLE}.toughness ;;
  }

  dimension: toughness_int {
    hidden: yes
    type: number
    sql: ${TABLE}.toughness_int ;;
  }

  dimension: has_text {
    type: yesno
    sql: ${oracle_text} is not null ;;
  }

  dimension: power_toughness {
    type: string
    sql: CONCAT(${power},"/",${toughness}) ;;
  }

  dimension: power_toughness_sum {
    type: string
    sql: ${TABLE}.power_toughness_sum ;;
  }

  dimension: power_toughness_sum_string {
    type: string
    case: {
      when: {
        sql: ${power_toughness_sum} = "0";;
        label: "00"
        }
      when: {
        sql: ${power_toughness_sum}="1" ;;
        label: "01"
      }
      when: {
        sql: ${power_toughness_sum}="2" ;;
        label: "02"
      }
      when: {
        sql: ${power_toughness_sum} = "3";;
        label: "03"
      }
      when: {
        sql: ${power_toughness_sum}="4" ;;
        label: "04"
      }
      when: {
        sql: ${power_toughness_sum}="5" ;;
        label: "05"
      }
      when: {
        sql: ${power_toughness_sum}="6" ;;
        label: "06"
      }
      when: {
        sql: ${power_toughness_sum}="7" ;;
        label: "07"
      }
      when: {
        sql: ${power_toughness_sum} = "8";;
        label: "08"
      }
      when: {
        sql: ${power_toughness_sum}="9" ;;
        label: "09"
      }
      when: {
        sql: ${power_toughness_sum} = "10";;
        label: "10"
      }
      when: {
        sql: ${power_toughness_sum}="11" ;;
        label: "11"
      }
      when: {
        sql: ${power_toughness_sum}="12" ;;
        label: "12"
      }
      when: {
        sql: ${power_toughness_sum} = "13";;
        label: "13"
      }
      when: {
        sql: ${power_toughness_sum}="14" ;;
        label: "14"
      }
      when: {
        sql: ${power_toughness_sum}="15" ;;
        label: "15"
      }
      when: {
        sql: ${power_toughness_sum}="16" ;;
        label: "16"
      }
      when: {
        sql: ${power_toughness_sum}="17" ;;
        label: "17"
      }
      when: {
        sql: ${power_toughness_sum} = "18";;
        label: "18"
      }
      when: {
        sql: ${power_toughness_sum}="19" ;;
        label: "19"
      }
      when: {
        sql: ${power_toughness_sum} = "20";;
        label: "20"
      }
      when: {
        sql: ${power_toughness_sum}="21" ;;
        label: "21"
      }
      when: {
        sql: ${power_toughness_sum}="22" ;;
        label: "22"
      }
      when: {
        sql: ${power_toughness_sum} = "23";;
        label: "23"
      }
      when: {
        sql: ${power_toughness_sum}="24" ;;
        label: "24"
      }
      when: {
        sql: ${power_toughness_sum}="25" ;;
        label: "25"
      }
      when: {
        sql: ${power_toughness_sum}="26" ;;
        label: "26"
      }
      when: {
        sql: ${power_toughness_sum}="27" ;;
        label: "27"
      }
      when: {
        sql: ${power_toughness_sum} = "28";;
        label: "28"
      }
      when: {
        sql: ${power_toughness_sum}="29" ;;
        label: "29"
      }
      when: {
        sql: ${power_toughness_sum} = "30";;
        label: "30"
      }
      when: {
        sql: ${power_toughness_sum}="31" ;;
        label: "31"
      }
      when: {
        sql: ${power_toughness_sum}="32" ;;
        label: "32"
      }
      when: {
        sql: ${power_toughness_sum} = "33";;
        label: "33"
      }
      when: {
        sql: ${power_toughness_sum}="34" ;;
        label: "34"
      }
      when: {
        sql: ${power_toughness_sum}="35" ;;
        label: "35"
      }
      when: {
        sql: ${power_toughness_sum}="36" ;;
        label: "36"
      }
      when: {
        sql: ${power_toughness_sum}="37" ;;
        label: "37"
      }
      when: {
        sql: ${power_toughness_sum} = "38";;
        label: "38"
      }
      when: {
        sql: ${power_toughness_sum}="39" ;;
        label: "39"
      }
      when: {
        sql: ${power_toughness_sum}="Variable" ;;
        label: "Variable"
      }

    }
  }


  dimension: sum_power_toughness {
    type: string
    sql: CONCAT(${power_toughness_sum_string}," - ",${power_toughness}) ;;
  }

  dimension: power {
    hidden: yes
    type: string
    sql: ${TABLE}.power ;;
  }

  dimension: power_int {
    hidden:  yes
    type: number
    sql: ${TABLE}.power_int ;;
  }

  dimension: loyalty {

    type: number
    sql: ${TABLE}.loyalty ;;
  }

  dimension: loyalty_int {
    hidden: yes
    type: number
    sql: ${TABLE}.loyalty_int ;;
  }

  dimension: cmc {
    label: "Converted Mana Cost"
    type: string
    sql: CAST(${TABLE}.cmc as STRING) ;;
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
    drill_fields: [name, oracle_text,type_line,mana_cost,power_toughness]
  }

  }

  view: indexes {
    derived_table: {
      sql:
      SELECT
          ${cards_gameplay.SQL_TABLE_NAME}.card_name as name,
          CASE WHEN ${cards_gameplay.SQL_TABLE_NAME}.loyalty_int is null then (${cards_gameplay.SQL_TABLE_NAME}.toughness_int+${cards_gameplay.SQL_TABLE_NAME}.power_int)
          WHEN ${cards_gameplay.SQL_TABLE_NAME}.loyalty_int is not null then ${cards_gameplay.SQL_TABLE_NAME}.loyalty_int END AS strength_index,
          CASE WHEN ${cards_gameplay.SQL_TABLE_NAME}.cmc=0 then 1
          ELSE ${cards_gameplay.SQL_TABLE_NAME}.cmc END AS cmc,
          count(behavior.behavior) as behavior_count
          FROM ${cards_gameplay.SQL_TABLE_NAME}
          JOIN hilary_thesis.behavior on ${cards_gameplay.SQL_TABLE_NAME}.card_name = behavior.name
          group by 1,2,3;;
    }

  dimension: cmc {
    label: "Indexed Converted Mana Cost"
    type: number
    sql: ${TABLE}.cmc;;
  }

  measure: average_cmc{
    label: "Average Converted Mana Cost"
    type: average
    sql: ${TABLE}.cmc ;;
  }

  dimension: strength_index {
    type: number
    sql: ${TABLE}.strength_index ;;
  }

  dimension: behavior_count {
    type: number
    sql: ${TABLE}.behavior_count ;;
  }

  dimension: base_mana_index {
    type: number
    sql: ${strength_index}/${cmc} ;;
  }


  measure: max_mana_index {
    type: max
    sql: ${base_mana_index} ;;
  }
  measure: max_strength_index {
    type: max
    sql: ${strength_index} ;;
  }

    measure: min_mana_index {
      type: min
      sql: ${base_mana_index} ;;
    }
    measure: min_strength_index {
      type: min
      sql: ${strength_index} ;;
    }

    measure: avg_mana_index {
      type: average
      sql: ${base_mana_index} ;;
    }
    measure: avg_strength_index {
      type: average
      sql: ${strength_index} ;;
    }

  }
