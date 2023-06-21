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
  label: "all_joins_without_always_join"
  #always_join: [dim_recruit_company_data,recruit_tests,recruit_attempts,recruit_solves,dim_content_questions]

  join: dim_recruit_company_data {
    type: inner
    relationship: one_to_one
    sql_on: ${ever_paid_companies_inc_tcs.company_id} = ${dim_recruit_company_data.company_data_company_id} ;;
  }

  join: recruit_tests {
    type: inner
    relationship: one_to_many
    sql_on: ${ever_paid_companies_inc_tcs.company_id} = abs(${recruit_tests.company_id}) ;;
    sql_where: ${recruit_tests.draft} = 0
      and ${recruit_tests.state} <> 3 ;;
  }

  join: fact_recruit_additonal_tag_mapping {
    type: inner
    relationship: one_to_many
    sql_on: ${fact_recruit_additonal_tag_mapping.additional_tag_mapping_entity_id} = ${recruit_tests.id};;
  }

  join: fact_recruit_additonal_tag {
    type: inner
    relationship: one_to_many
    sql_on: ${fact_recruit_additonal_tag.additional_tag_id} = ${fact_recruit_additonal_tag_mapping.additional_tag_mapping_tag_id};;
  }

  join: fact_rs_roles {
    type: inner
    relationship: one_to_many
    sql_on: ${fact_rs_roles.role_unique_id} = ${fact_recruit_additonal_tag.additional_tag_usage};;
  }

  join: fact_rs_role_skill_associations {
    type: inner
    relationship: one_to_many
    sql_on: ${fact_rs_role_skill_associations.role_skill_association_role_id} = ${fact_rs_roles.role_id};;
    }

  join: fact_rs_skills {
    type: inner
    relationship: one_to_many
    sql_on: ${fact_rs_skills.skill_id} = ${fact_rs_role_skill_associations.role_skill_association_skill_id};;
    }

  join: recruit_tests_questions {
    type: inner
    relationship: one_to_many
    sql_on: ${recruit_tests.id} = ${recruit_tests_questions.test_id} ;;
  }

  join: question_skill_mapping {
    type: inner
    relationship: one_to_many
    sql_on: ${recruit_tests_questions.question_id} = ${question_skill_mapping.id};;
  }

  join: roles_tests_tagging {
    type: left_outer
    relationship: one_to_one
    sql_on: ${roles_tests_tagging.test_id} = ${recruit_tests.id} ;;
  }
  join: recruit_test_feedback {
    type: left_outer
    relationship: one_to_many
    sql_on: ${recruit_tests.unique_id} = ${recruit_test_feedback.test_hash} ;;
  }
  join: recruit_test_candidates {
    type: left_outer
    relationship: one_to_many
    sql_on: ${recruit_test_candidates.test_id} = ${recruit_tests.id} ;;
  }
  join: recruit_attempts {
    type: inner
    relationship: one_to_many
    sql_on: abs(${recruit_tests.id}) = abs(${recruit_attempts.tid}) ;;
    sql_where: ${recruit_attempts.tid} > 0
          and lower(${recruit_attempts.email}) not like '%@hackerrank.com%'
          and lower(${recruit_attempts.email}) not like '%@hackerrank.net%'
          and lower(${recruit_attempts.email}) not like '%@interviewstreet.com%'
          and lower(${recruit_attempts.email}) not like '%sandbox17e2d93e4afe44ea889d89aadf6d413f.mailgun.org%'
          and lower(${recruit_attempts.email}) not like '%strongqa.com%'
          and ${recruit_attempts.status} =  7 ;;
  }
  join: recruit_solves {
    type: inner
    relationship: one_to_many
    sql_on: ${recruit_attempts.id} = ${recruit_solves.aid} ;;
    sql_where: ${recruit_solves.aid} > 0
      and ${recruit_solves.status} = 2 ;;
  }
  join: dim_content_questions {
    type: inner
    relationship: one_to_one
    sql_on: ${recruit_solves.qid} = ${dim_content_questions.question_id} ;;
  }
  # join: questions_skills_tagging {
  #   type: inner
  #   relationship: one_to_many
  #   sql_on: ${dim_content_questions.question_id} = ${questions_skills_tagging.id} ;;
  # }
  join: salesforce_accounts {
    type: inner
    relationship: one_to_many
    sql_on: ${salesforce_accounts.hrid_c} = ${ever_paid_companies_inc_tcs.company_id};;
  }
}
