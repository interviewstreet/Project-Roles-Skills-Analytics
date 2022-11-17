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
explore: ever_paid_companies_inc_tcs {
  join: dim_recruit_company_data {
    type: inner
    relationship: one_to_one
    sql_on: ${ever_paid_companies_inc_tcs.company_id} = ${dim_recruit_company_data.company_data_company_id} ;;
  }
  join: recruit_tests {
    type: inner
    relationship: one_to_many
    sql_on: ${dim_recruit_company_data.company_data_company_id} = ${recruit_tests.company_id} ;;
  }
  join: recruit_test_attempts {
    type: inner
    relationship: one_to_many
    sql_on: ${recruit_tests.id} = ${recruit_test_attempts.test_id} ;;
  }
  join: recruit_solves {
    type: inner
    relationship: one_to_many
    sql_on: ${recruit_test_attempts.id} = ${recruit_solves.aid} ;;
  }
  join: dim_content_questions {
    type: inner
    relationship: one_to_one
    sql_on: ${recruit_solves.qid} = ${dim_content_questions.question_id} ;;
  }
}
