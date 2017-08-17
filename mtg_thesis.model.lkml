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
#
# #Base Explores for PDTs
# explore: prices {
#   hidden: yes
#   persist_with: prices_datagroup
#   view_label: "xPrices"
# }
#
# explore: cards_flat {
#   hidden: yes
#   persist_with: cards_datagroup
#   view_label: "xCards"
# }
#
# explore: keywords {
#   hidden: yes
#   persist_with: cards_datagroup
#   view_label: "xKeywords"
# }
#
# explore: sets {
#   hidden: yes
#   persist_with: cards_datagroup
#   view_label: "xSets"
# }
#
# explore: subtypes {
#   hidden: yes
#   persist_with: cards_datagroup
#   view_label: "xSubtypes"
# }
#
# explore: types {
#   hidden: yes
#   persist_with: cards_datagroup
#   view_label: "xTypes"
# }

#Useful Models

explore: current_price {
  persist_with: prices_datagroup
  join: cards_collection {
    sql_on: ${current_price.multiverse_id}=${cards_collection.multiverse_id} ;;
    relationship: one_to_one
  }
  join: sets {
    sql_on: ${cards_collection.set_id}=${sets.code} ;;
    relationship: many_to_one
  }
}

explore: pricing_history {
  persist_with: prices_datagroup
  join: cards_collection {
    sql_on: ${pricing_history.multiverse_id}=${cards_collection.multiverse_id} ;;
    relationship: many_to_one
  }
  join: sets {
    sql_on: ${cards_collection.set_id}=${sets.code} ;;
    relationship: many_to_one
  }
}

explore: cards_gameplay {

  sql_always_where: ${sets.set_type} = "core" OR ${sets.set_type}="expansion" ;;
  join: behavior {
    sql_on: ${cards_gameplay.name}=${behavior.name} ;;
    relationship: one_to_many
  }
  join: subtypes_cards {
    sql_on: ${cards_gameplay.name}=${subtypes_cards.card_name} ;;
    relationship: one_to_many
  }
  join: sets {
    sql_on: ${cards_gameplay.set_name}=${sets.name} ;;
    relationship: many_to_one
  }
  join: indexes {
    sql_on: ${cards_gameplay.name}=indexes.name ;;
    relationship: one_to_one
  }


}
explore: sets {
  join: cards_gameplay {
    sql_on: ${sets.name}=${cards_gameplay.set_name} ;;
    relationship: one_to_many
  }
  join: behavior{
    sql_on: ${cards_gameplay.name}=${behavior.name} ;;
    relationship: one_to_many
  }
  join: indexes {
    sql_on: ${cards_gameplay.name}=indexes.name ;;
    relationship: one_to_one
  }
}
#
# explore: creatures {
#   join: cards_gameplay {
#     sql_on: ${creatures.card_name}=${cards_gameplay.name} ;;
#     relationship: many_to_one
#   }
#   join: behavior {
#     sql_on: ${creatures.card_name}=${behavior.name} ;;
#     relationship: many_to_many
#   }
# }
#
# explore: instants {
#   join: cards_gameplay {
#     sql_on: ${instants.card_name}=${cards_gameplay.name} ;;
#     relationship: many_to_one
#   }
# }
