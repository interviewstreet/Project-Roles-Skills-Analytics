view: recruit_test_feedback {
  sql_table_name: recruit.recruit_test_feedback ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: col1 {
    type: number
    sql: ${TABLE}.col1 ;;
  }

  dimension: col2 {
    type: number
    sql: ${TABLE}.col2 ;;
  }

  dimension: col3 {
    type: number
    sql: ${TABLE}.col3 ;;
  }

  dimension: col4 {
    type: number
    sql: ${TABLE}.col4 ;;
  }

  dimension: col5 {
    type: number
    sql: ${TABLE}.col5 ;;
  }

  dimension: col6 {
    type: number
    sql: ${TABLE}.col6 ;;
  }

  dimension: comments {
    type: string
    sql: ${TABLE}.comments ;;
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

  dimension_group: inserttime {
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
    sql: ${TABLE}.inserttime ;;
  }

  dimension: interface {
    type: string
    sql: ${TABLE}.interface ;;
  }

  dimension: mail_sent {
    type: number
    sql: ${TABLE}.mail_sent ;;
  }

  dimension: metadata {
    type: string
    sql: ${TABLE}.metadata ;;
  }

  dimension: product_rating {
    type: number
    sql: ${TABLE}.product_rating ;;
  }

  dimension: question_rating {
    type: number
    sql: ${TABLE}.question_rating ;;
  }

  dimension: test_candidate_id {
    type: number
    sql: ${TABLE}.test_candidate_id ;;
  }

  dimension: test_hash {
    type: string
    sql: ${TABLE}.test_hash ;;
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

  dimension: user_email {
    type: string
    sql: ${TABLE}.user_email ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
