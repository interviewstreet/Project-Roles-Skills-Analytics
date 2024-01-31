connection: "recruit_rs_replica"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
explore: recruit_tests {
  join: recruit_users {
    type: left_outer
    relationship: one_to_one
    sql_on: ${recruit_tests.owner} = ${recruit_users.id} ;;
  }
  join: recruit_tests_questions {
    type: left_outer
    relationship: one_to_many
    sql_on:  ${recruit_tests_questions.test_id} = ${recruit_tests.id};;
  }

  join: dim_content_questions {
    type: left_outer
    relationship: one_to_one
    sql_on:  ${recruit_tests_questions.question_id} = ${dim_content_questions.question_id};;
  }

  join: recruit_test_feedback {
    type: left_outer
    relationship: one_to_many
    sql_on:  ${recruit_tests.unique_id} = ${recruit_test_feedback.test_hash};;
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
