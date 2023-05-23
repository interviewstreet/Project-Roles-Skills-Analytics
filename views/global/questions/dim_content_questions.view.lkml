view: dim_content_questions {
  sql_table_name: global.dim_content_questions ;;

  dimension: companyid {
    type: string
    sql: ${TABLE}.companyid ;;
  }

  dimension: question_added_to_library_on_list {
    type: string
    sql: ${TABLE}.question_added_to_library_on_list ;;
  }

  dimension: question_authkey {
    type: string
    sql: ${TABLE}.question_authkey ;;
  }

  dimension: question_author {
    type: string
    sql: ${TABLE}.question_author ;;
  }

  dimension: question_company_id {
    type: string
    sql: ${TABLE}.question_company_id ;;
  }

  dimension: question_content_quality {
    type: string
    sql: ${TABLE}.question_content_quality ;;
  }

  dimension: question_copyscape_max_percentage {
    type: string
    sql: ${TABLE}.question_copyscape_max_percentage ;;
  }

  dimension_group: question_created {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.question_created_at ;;
  }

  dimension: question_custom {
    type: string
    sql: ${TABLE}.question_custom ;;
  }

  dimension: question_custom_super {
    type: string
    sql: ${TABLE}.question_custom_super ;;
  }

  dimension: question_deleted {
    type: number
    sql: ${TABLE}.question_deleted ;;
  }

  dimension: question_draft {
    type: number
    sql: ${TABLE}.question_draft ;;
  }

  dimension: question_evaluator_params {
    type: string
    sql: ${TABLE}.question_evaluator_params ;;
  }

  dimension: question_format {
    type: string
    sql: ${TABLE}.question_format ;;
  }

  dimension: question_id {
    type: number
    sql: ${TABLE}.question_id ;;
  }

  dimension: question_internal_notes {
    type: string
    sql: ${TABLE}.question_internal_notes ;;
  }

  dimension: question_is_leaked {
    type: string
    sql: ${TABLE}.question_is_leaked ;;
  }

  dimension: question_is_valid {
    type: number
    value_format_name: id
    sql: ${TABLE}.question_is_valid ;;
  }

  dimension: question_leaked_data {
    type: string
    sql: ${TABLE}.question_leaked_data ;;
  }

  dimension: question_leaked_data_updated_at {
    type: string
    sql: ${TABLE}.question_leaked_data_updated_at ;;
  }

  dimension: question_level {
    type: string
    sql: ${TABLE}.question_level ;;
  }

  dimension: question_manually_marked_leaked {
    type: string
    sql: ${TABLE}.question_manually_marked_leaked ;;
  }

  dimension: question_name {
    type: string
    sql: ${TABLE}.question_name ;;
  }

  dimension: question_proficiency {
    type: string
    sql: case when lower(${TABLE}.question_tags) like '%easy%' then 'easy'
      when lower(${TABLE}.question_tags) like '%medium%' then 'medium'
      when lower(${TABLE}.question_tags) like '%hard%' then 'hard'
      else 'not mentioned' end;;
  }

  dimension: question_parent_id {
    type: number
    sql: ${TABLE}.question_parent_id ;;
  }

  dimension: question_points {
    type: string
    sql: ${TABLE}.question_points ;;
  }

  dimension: question_problem_statement {
    type: string
    sql: ${TABLE}.question_problem_statement ;;
  }

  dimension: question_product {
    type: number
    sql: ${TABLE}.question_product ;;
  }

  dimension: question_product_id {
    type: number
    sql: ${TABLE}.question_product_id ;;
  }

  dimension: question_recommended_duration {
    type: string
    sql: ${TABLE}.question_recommended_duration ;;
  }

  dimension: question_score {
    type: number
    sql: ${TABLE}.question_score ;;
  }

  dimension: question_skills_obj {
    type: string
    sql: ${TABLE}.question_skills_obj ;;
  }

  dimension: question_stack {
    type: string
    sql: ${TABLE}.question_stack ;;
  }

  dimension: question_stack_type {
    type: string
    sql: ${TABLE}.question_stack_type ;;
  }

  dimension: question_status {
    type: number
    sql: ${TABLE}.question_status ;;
  }

  dimension: question_tags {
    type: string
    sql: ${TABLE}.question_tags ;;
  }

  dimension: question_template_type {
    type: string
    sql: ${TABLE}.question_template_type ;;
  }

  dimension: question_templates {
    type: string
    sql: ${TABLE}.question_templates ;;
  }

  dimension: question_test_cases_total_count {
    type: number
    sql: ${TABLE}.question_test_cases_total_count ;;
  }

  dimension: question_testcases {
    type: string
    sql: ${TABLE}.question_testcases ;;
  }

  dimension: question_total_quality_score {
    type: string
    sql: ${TABLE}.question_total_quality_score ;;
  }

  dimension: question_type {
    type: string
    sql: ${TABLE}.question_type ;;
  }

  dimension: question_type_attributes {
    type: string
    sql: ${TABLE}.question_type_attributes ;;
  }

  dimension: question_unique_id {
    type: string
    sql: ${TABLE}.question_unique_id ;;
  }

  dimension_group: question_updated {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.question_updated_at ;;
  }

  dimension: question_version {
    type: number
    sql: ${TABLE}.question_version ;;
  }

  measure: count {
    type: count
    drill_fields: [question_name, question_id, question_type]
  }

  ## custom role type
  dimension: question_role_type {
    type: string
    sql: case WHEN question_type = 'fullstack'
                   AND json_extract_path_text(question_type_attributes, 'role_type') = 'fullstack' THEN 'Fullstack'
              WHEN question_type = 'fullstack'
                   AND json_extract_path_text(question_type_attributes, 'role_type') = 'mobile' THEN 'Fullstack-Mobile'
              WHEN question_type = 'fullstack'
                   AND json_extract_path_text(question_type_attributes, 'role_type') = 'frontend' THEN 'Fullstack-Frontend'
              WHEN question_type = 'fullstack'
                   AND json_extract_path_text(question_type_attributes, 'role_type') = 'backend' THEN 'Fullstack-Backend'
              WHEN question_type = 'fullstack'
                   AND json_extract_path_text(question_type_attributes, 'role_type') = 'datascience' THEN 'Fullstack-Datascience'
              WHEN question_type = 'sudorank' and lower(${question_tags}) like '%aws cli%' THEN 'AWS'
              WHEN question_type = 'sudorank' THEN 'Fullstack-Devops'
              WHEN question_type = 'database' THEN 'Database'
              WHEN question_type = 'fullstack'
                   AND json_extract_path_text(question_type_attributes, 'role_type') IS NULL THEN 'Fullstack-NULL'
              else 'Others'
              end;;
  }

  dimension: question_stack_sub_type {
    type: string
    sql: json_extract_path_text(question_type_attributes, 'sub_type',true) ;;
  }


  dimension: question_run_command  {
    type: string
    sql: json_extract_path_text(question_stack, 'ide_config','menu','run','command',true) ;;
  }

  dimension: question_install_command  {
    type: string
    sql: json_extract_path_text(question_stack, 'ide_config','menu','install','command',true) ;;
  }

  dimension: question_test_command  {
    type: string
    sql: json_extract_path_text(question_stack, 'ide_config','menu','test','command',true) ;;
  }

  dimension: library_question {
    type: string
    sql: case when ${question_company_id} = 14357 then 'yes' else 'no' end;;
  }
}
