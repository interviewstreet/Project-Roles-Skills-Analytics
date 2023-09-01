connection: "recruit_rs_replica"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
explore: ever_paid_companies_inc_tcs {
  join: recruit_interviews {
    type: inner
    relationship: one_to_many
    sql_on: ${ever_paid_companies_inc_tcs.company_id} = ${recruit_interviews.company_id} ;;
  }

  join: recruit_interview_attendant_data {
    type: inner
    relationship: one_to_many
    sql_on: ${recruit_interviews.id} = ${recruit_interview_attendant_data.ia_id} ;;
  }

  join: recruit_interview_attendants {
    type: inner
    relationship: one_to_many
    sql_on: ${recruit_interviews.id} = ${recruit_interview_attendants.interview_id} ;;
  }

  join: recruit_interview_data {
    type: inner
    relationship: one_to_many
    sql_on: ${recruit_interviews.id} = ${recruit_interview_data.interview_id} ;;
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
