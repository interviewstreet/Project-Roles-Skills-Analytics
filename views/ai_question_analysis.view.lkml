view: ai_question_analysis {
  sql_table_name: analytics_platform.reporting.ai_question_analysis ;;

  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: fully_solved {
    type: yesno
    sql: ${TABLE}.fully_solved ;;
  }
  dimension: largely_skipped_by_plagiarism_model {
    type: yesno
    sql: ${TABLE}.largely_skipped_by_plagiarism_model ;;
  }
  dimension: max_score {
    type: number
    sql: ${TABLE}.max_score ;;
  }
  dimension: model {
    type: string
    sql: ${TABLE}.model ;;
  }
  dimension: percentage {
    type: number
    sql: ${TABLE}.percentage ;;
  }
  dimension: question_id {
    type: number
    sql: ${TABLE}.question_id ;;
  }
  dimension: score {
    type: number
    sql: ${TABLE}.score ;;
  }
  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_at ;;
  }
  measure: count {
    type: count
  }
}
