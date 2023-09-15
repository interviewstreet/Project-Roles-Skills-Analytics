connection: "recruit_rs_replica"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
explore: dim_content_questions {

  join: ai_question_analysis {
    type: inner
    relationship: one_to_one
    sql_on: ${ai_question_analysis.question_id} = ${dim_content_questions.question_id} ;;
  }

  join: recruit_solves {
    type: inner
    relationship: one_to_many
    sql_on: ${ai_question_analysis.question_id} = ${recruit_solves.qid} ;;
    sql_where: ${recruit_solves.aid} > 0
      and ${recruit_solves.status} = 2 ;;
  }

  join: recruit_attempts {
    type: inner
    relationship: many_to_one
    sql_on: abs(${recruit_solves.aid}) = abs(${recruit_attempts.id}) ;;
    sql_where: ${recruit_attempts.tid} > 0
          and lower(${recruit_attempts.email}) not like '%@hackerrank.com%'
          and lower(${recruit_attempts.email}) not like '%@hackerrank.net%'
          and lower(${recruit_attempts.email}) not like '%@interviewstreet.com%'
          and lower(${recruit_attempts.email}) not like '%sandbox17e2d93e4afe44ea889d89aadf6d413f.mailgun.org%'
          and lower(${recruit_attempts.email}) not like '%strongqa.com%'
          and ${recruit_attempts.status} =  7 ;;
  }

  join: recruit_tests {
    type: inner
    relationship: many_to_one
    sql_on: ${recruit_attempts.tid} = abs(${recruit_tests.id}) ;;
    sql_where: ${recruit_tests.draft} = 0
      and ${recruit_tests.state} <> 3 ;;
  }

  join: recruit_tests_questions {
    type: inner
    relationship: one_to_many
    sql_on: ${recruit_tests.id} = ${recruit_tests_questions.test_id}  ;;
  }

  join: ever_paid_companies_inc_tcs {
    type: inner
    relationship: many_to_one
    sql_on: ${recruit_tests.company_id} = ${ever_paid_companies_inc_tcs.company_id} ;;
  }


  join: recruit_users {
    type: inner
    relationship: one_to_one
    sql_on: ${dim_content_questions.author_id} = ${recruit_users.id};;
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
