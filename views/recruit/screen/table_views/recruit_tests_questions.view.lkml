view: recruit_tests_questions {
  sql_table_name: recruit.recruit_tests_questions ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: active {
    type: number
    sql: ${TABLE}.active ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension: extra_int1 {
    type: number
    sql: ${TABLE}.extra_int1 ;;
  }

  dimension: extra_int2 {
    type: number
    sql: ${TABLE}.extra_int2 ;;
  }

  dimension: extra_string1 {
    type: string
    sql: ${TABLE}.extra_string1 ;;
  }

  dimension: extra_string2 {
    type: string
    sql: ${TABLE}.extra_string2 ;;
  }

  dimension: question_id {
    type: number
    sql: ${TABLE}.question_id ;;
  }

  dimension: test_id {
    type: number
    sql: ${TABLE}.test_id ;;
  }

  dimension_group: updated {
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
    sql: ${TABLE}.updated_at ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
