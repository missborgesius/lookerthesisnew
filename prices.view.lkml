include: "mtg_thesis.model.lkml"

view: prices {
  sql_table_name: hilary_thesis.prices ;;

  dimension_group: date {
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
    sql: ${TABLE}.date ;;
  }

  dimension: multiverse_id {
    type: number
    sql: ${TABLE}.multiverse_id ;;
  }

  dimension: usd {
    type: number
    sql: ${TABLE}.usd ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}

view: current_price {
  derived_table: {
    sql:SELECT prices_a.multiverse_id as multiverse_id, prices_a.usd as most_recent_price, prices_a.date as most_recent_data
        FROM hilary_thesis.prices as prices_a
        INNER JOIN
          (SELECT MAX(date) as date, multiverse_id
          FROM hilary_thesis.prices
          group by multiverse_id) as prices_b
        on prices_a.date = prices_b.date
        and prices_a.multiverse_id = prices_b.multiverse_id;;
  }

dimension: multiverse_id{
  type: number
  primary_key: yes
  sql: ${TABLE}.multiverse_id ;;
}
dimension_group: most_recent_data {
  type: time
  timeframes: [date, month, year]
  sql: ${TABLE}.most_recent_data ;;
}
dimension: most_recent_price {
  type: number
  value_format_name: usd
  sql: ${TABLE}.most_recent_price ;;
}
measure: count {
  type: count
}

measure: min_price {
  type: min
  sql: ${most_recent_price} ;;
}

measure: max_price {
  type: max
  sql: ${most_recent_price} ;;
}

measure: avg_price {
  type: average
  sql: ${most_recent_price} ;;
}

}

view: pricing_history {
  derived_table: {
    sql: SELECT ROW_NUMBER() OVER (order by multiverse_id) as id, multiverse_id as multiverse_id, usd as price, date as data_gathered FROM hilary_thesis.prices;;
}
dimension: id {
  type: number
  primary_key: yes
  sql: ${TABLE}.id ;;
}

dimension: multiverse_id {
  type: number
  sql: ${TABLE}.multiverse_id ;;
}

dimension: price {
  type: number
  value_format_name: usd
  sql: ${TABLE}.price ;;
}

dimension_group: data_gathered {
  type: time
  timeframes: [year, month, date]
  sql: ${TABLE}.data_gathered ;;
}

measure: count {
  type: count
}

measure: min_price {
  type: min
  sql: ${price} ;;
}

measure: max_price {
  type: max
  sql: ${price} ;;
}

measure: avg_price {
  type: average
  sql: ${price} ;;
}

measure: min_max_spread{
  type: number
  sql: ${max_price}-${min_price} ;;
}


















}
