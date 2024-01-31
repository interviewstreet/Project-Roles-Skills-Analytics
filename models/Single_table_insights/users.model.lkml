connection: "recruit_rs_replica"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
explore: recruit_users {
  join: recruit_test_candidates {
    type: left_outer
    relationship: one_to_many
    sql_on: ${recruit_users.id} = ${recruit_test_candidates.user_id} ;;
  }
  join: recruit_user_team_mappings {
    type: left_outer
    relationship: one_to_many
    sql_on: ${recruit_users.id} = ${recruit_user_team_mappings.user_id} ;;
  }
  join: recruit_teams {
    type: left_outer
    relationship: many_to_one
    sql_on: ${recruit_user_team_mappings.team_id} = ${recruit_teams.id} ;;
  }
}
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }
