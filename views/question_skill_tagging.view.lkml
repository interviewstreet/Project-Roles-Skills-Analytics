view: questions_skills_tagging {
  derived_table: {
    sql: with
      questions as
        (SELECT id, json_extract_path_text(custom, 'skills_obj', true) as skills , json_array_length(json_extract_path_text(custom, 'skills_obj', true), true) as no_of_skills
        FROM content_rs_replica.content.questions dcq
        WHERE json_array_length(json_extract_path_text(custom, 'skills_obj', true), true) > 0
        -- json_extract_path_text(custom, 'skills_obj', true) is not null and json_extract_path_text(custom, 'skills_obj', true) != '[]'
        ),
      range_sequence AS
        (
        SELECT 0 AS i UNION ALL
        SELECT 1 UNION ALL
        SELECT 2 UNION ALL
        SELECT 3 UNION ALL
        SELECT 4 UNION ALL
        SELECT 5 UNION ALL
        SELECT 6 UNION ALL
        SELECT 7 UNION ALL
        SELECT 8 UNION ALL
        SELECT 9 UNION ALL
        SELECT 10 UNION ALL
        SELECT 11 UNION ALL
        SELECT 12
        )

      SELECT
      range_sequence.i,
      questions.id,
      skills,
      no_of_skills,
      JSON_EXTRACT_PATH_TEXT(JSON_EXTRACT_ARRAY_ELEMENT_TEXT(questions.skills,range_sequence.i, true),'name', true) as skill_name,
      JSON_EXTRACT_PATH_TEXT(JSON_EXTRACT_ARRAY_ELEMENT_TEXT(questions.skills,range_sequence.i, true),'unique_id', true) as skill_unique_id,
      case when json_extract_path_text(json_extract_array_element_text(skills,i, true),'name', true) like '% (Basic)%' then rtrim(json_extract_path_text(json_extract_array_element_text(skills,i, true),'name', true), '(Basic)')
      when json_extract_path_text(json_extract_array_element_text(skills,i, true),'name', true) like '% (Advanced)%' then rtrim(json_extract_path_text(json_extract_array_element_text(skills,i, true),'name', true), '(Advanced)')
      when json_extract_path_text(json_extract_array_element_text(skills,i, true),'name', true) like '% (Intermediate)%' then rtrim(json_extract_path_text(json_extract_array_element_text(skills,i, true),'name', true), '(Intermediate)')
      else json_extract_path_text(json_extract_array_element_text(skills,i, true),'name', true) end as modified_skill_name

      from questions,range_sequence
      where skill_name <> ''
      -- order by id desc, i
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: i {
    type: number
    sql: ${TABLE}.i ;;
  }

  dimension: id {
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: skills {
    type: string
    sql: ${TABLE}.skills ;;
  }

  dimension: no_of_skills {
    type: number
    sql: ${TABLE}.no_of_skills ;;
  }

  dimension: skill_name {
    type: string
    sql: ${TABLE}.skill_name ;;
  }

  dimension: skill_unique_id {
    type: string
    sql: ${TABLE}.skill_unique_id ;;
  }

  dimension: modified_skill_name {
    type: string
    sql: ${TABLE}.modified_skill_name ;;
  }

  measure: tests_list {
    type: string
    sql: listagg(distinct ${recruit_tests.id},', ') ;;
  }

  measure: test_count {
    type: number
    sql: regexp_count( ${tests_list} ,', ')+1 ;;
  }

  set: detail {
    fields: [
      i,
      id,
      skills,
      no_of_skills,
      skill_name,
      skill_unique_id,
      modified_skill_name
    ]
  }
}
