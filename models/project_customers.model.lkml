connection: "recruit_rs_replica"

#include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
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
explore:  ever_paid_companies_inc_tcs{
  label: "project_customers"
  join: dim_recruit_company_data {
    type: inner
    sql_on: ${ever_paid_companies_inc_tcs.company_id} = ${dim_recruit_company_data.company_data_company_id};;
    relationship: one_to_one
  }
  }
