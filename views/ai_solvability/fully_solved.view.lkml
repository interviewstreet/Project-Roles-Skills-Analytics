
view: fully_solved {
  derived_table: {
    sql: SELECT
          dim_content_questions.question_type  AS "dim_content_questions.question_type",
          case when lower(dim_content_questions.question_tags) like '%easy%' then 'easy'
            when lower(dim_content_questions.question_tags) like '%medium%' then 'medium'
            when lower(dim_content_questions.question_tags) like '%hard%' then 'hard'
            else 'not mentioned' end AS question_proficiency,
          COUNT(DISTINCT ai_question_analysis.question_id) AS "Total_Questions",
          sum(case when percentage = 100 and model = 'gpt-3' then 1 else 0 end) AS "GPT3_Solved",
          sum(case when percentage = 100 and model = 'gpt-4' then 1 else 0 end) AS "GPT4_Solved"
      FROM hr_analytics.global.dim_content_questions  AS dim_content_questions
      INNER JOIN analytics_platform.reporting.ai_question_analysis  AS ai_question_analysis ON ai_question_analysis.question_id = dim_content_questions.question_id
      where
      question_proficiency <> 'not mentioned'
      GROUP BY
          1,
          2
          order by 1,2 asc
      LIMIT 500 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: dim_content_questions_question_type {
    type: string
    sql: ${TABLE}."dim_content_questions.question_type" ;;
  }

  dimension: question_proficiency {
    type: string
    sql: ${TABLE}.question_proficiency ;;
  }

  dimension: total_questions {
    type: number
    sql: ${TABLE}.total_questions ;;
  }

  dimension: gpt3_solved {
    type: number
    sql: ${TABLE}.gpt3_solved ;;
  }

  dimension: gpt4_solved {
    type: number
    sql: ${TABLE}.gpt4_solved ;;
  }

  set: detail {
    fields: [
      dim_content_questions_question_type,
      question_proficiency,
      total_questions,
      gpt3_solved,
      gpt4_solved
    ]
  }
}
