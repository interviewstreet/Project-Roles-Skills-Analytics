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
  label: "project_customers_all_joins"
  always_join: [dim_recruit_company_data,recruit_tests,recruit_attempts,recruit_solves,dim_content_questions]
  join: dim_recruit_company_data {
    type: inner
    relationship: one_to_one
    sql_on: ${ever_paid_companies_inc_tcs.company_id} = ${dim_recruit_company_data.company_data_company_id} ;;
  }
  join: recruit_tests {
    type: inner
    relationship: one_to_many
    sql_on: ${ever_paid_companies_inc_tcs.company_id} = ${recruit_tests.company_id} ;;

  }
  join: recruit_test_feedback {
    type: left_outer
    relationship: one_to_many
    sql_on: ${recruit_tests.unique_id} = ${recruit_test_feedback.test_hash} ;;
  }
  join: recruit_attempts {
    type: inner
    relationship: one_to_many
    sql_on: ${recruit_tests.id} = ${recruit_attempts.tid} ;;
  }
  join: recruit_solves {
    type: inner
    relationship: one_to_many
    sql_on: ${recruit_attempts.id} = ${recruit_solves.aid} ;;
  }
  join: dim_content_questions {
    type: inner
    relationship: one_to_one
    sql_on: ${recruit_solves.qid} = ${dim_content_questions.question_id} ;;
  }
  join: salesforce_accounts {
    type: inner
    relationship: one_to_many
    sql_on: ${salesforce_accounts.hrid_c} = ${ever_paid_companies_inc_tcs.company_id};;
  }
}
