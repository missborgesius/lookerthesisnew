connection: "bq_mtg"

include: "*.view.lkml"         # include all views in this project
include: "*.dashboard.lookml"  # include all dashboards in this project

#Datagroups
datagroup: prices_datagroup {
  sql_trigger: CURRENT_DATE() ;;
  max_cache_age: "48 hours"}

datagroup: cards_datagroup {
  sql_trigger: 1 ;;
}

#Base Explores for PDTs
explore: prices {
  hidden: yes
  persist_with: prices_datagroup
  view_label: "xPrices"
}

explore: cards_flat {
  hidden: yes
  persist_with: cards_datagroup
  view_label: "xCards"
}

explore: keywords {
  hidden: yes
  persist_with: cards_datagroup
  view_label: "xKeywords"
}

explore: sets {
  hidden: yes
  persist_with: cards_datagroup
  view_label: "xSets"
}

explore: subtypes {
  hidden: yes
  persist_with: cards_datagroup
  view_label: "xSubtypes"
}

explore: types {
  hidden: yes
  persist_with: cards_datagroup
  view_label: "xTypes"
}

#Useful Models

explore: current_price {
  persist_with: prices_datagroup
  join: cards_collection {
    sql_on: ${current_price.multiverse_id}=${cards_collection.multiverse_id} ;;
    relationship: one_to_one
  }
}

explore: pricing_history {
  persist_with: prices_datagroup
  join: cards_collection {
    sql_on: ${pricing_history.multiverse_id}=${cards_collection.multiverse_id} ;;
    relationship: many_to_one
  }
}

explore: cards_gameplay {

}
