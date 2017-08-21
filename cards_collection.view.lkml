include: "mtg_thesis.model.lkml"

view: cards_collection {
  derived_table: {
    sql:SELECT ROW_NUMBER() OVER (ORDER BY cards_flat.name) as id,
        cards_flat.multiverse_id,
        cards_flat.artist,
        cards_flat.rarity,
        cards_flat.border_color,
        cards_flat.set_uri,
        cards_flat.uri,
        cards_flat.image_uri,
        cards_flat.frame,
        cards_flat.reserved,
        cards_flat.name AS card_name,
        cards_flat.set_id,
        cards_flat.watermark,
        sets.released_at
        FROM hilary_thesis.cards_flat
        JOIN hilary_thesis.sets ON cards_flat.set_id = sets.code;;
  }

  dimension: id {
    type: number
    primary_key: yes
    hidden: yes
    sql: ${TABLE}.id ;;
  }

  dimension: multiverse_id {
    type: number
    sql: ${TABLE}.multiverse_id ;;
  }

  dimension: artist {
    type: string
    sql: ${TABLE}.artist ;;
  }

  dimension: rarity {
    type: string
    sql: ${TABLE}.rarity ;;
  }

  dimension: border_color {
    type: string
    sql: ${TABLE}.border_color ;;
  }

  dimension: set_uri {
    type: string
    hidden:  yes
    sql: ${TABLE}.set_uri ;;
  }

  dimension: uri {
    type: string
    hidden: yes
    sql: ${TABLE}.uri ;;
  }

  dimension: image_uri {
    type:  string
    hidden: yes
    sql: ${TABLE}.image_uri ;;
  }

  dimension: frame {
    type: string
    sql: ${TABLE}.frame;;
  }

  dimension: reserved {
    type: string
    sql: ${TABLE}.frame ;;
  }

  dimension: card_name {
    type: string
    sql: ${TABLE}.card_name ;;
    link: {
      label: "Explore on Scryfall"
      url: "{{cards_collection.uri._value}}"
      icon_url: "https://scryfall.com/favicon.ico"
    }
  }

  dimension: set_id {
    type: string
    sql: ${TABLE}.set_id ;;
  }

  dimension: watermark {
    type: string
    sql: ${TABLE}.watermark ;;
  }

  dimension_group: released_at{
    type:  time
    timeframes: [date, year]
    sql: ${TABLE}.released_at ;;
  }

  dimension: card_image {
    sql: ${image_uri} ;;
    html:<img src="{{value}}" width="336" height="468"/>;;
  }

  measure: count {
    type: count
  }


}
