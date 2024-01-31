view: recruit_test_attempts {
  sql_table_name: recruit.recruit_test_attempts ;;
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

  dimension: ats_state {
    type: number
    sql: ${TABLE}.ats_state ;;
  }

  dimension: attempt_id {
    type: number
    sql: ${TABLE}.attempt_id ;;
  }

  dimension: candidate_uuid {
    type: string
    sql: ${TABLE}.candidate_uuid ;;
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

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension_group: end {
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
    sql: ${TABLE}.end_time ;;
  }

  dimension: extra_bool_1 {
    type: number
    sql: ${TABLE}.extra_bool_1 ;;
  }

  dimension: extra_int_1 {
    type: number
    sql: ${TABLE}.extra_int_1 ;;
  }

  dimension: extra_int_2 {
    type: number
    sql: ${TABLE}.extra_int_2 ;;
  }

  dimension: extra_string_1 {
    type: string
    sql: ${TABLE}.extra_string_1 ;;
  }

  dimension: extra_string_2 {
    type: string
    sql: ${TABLE}.extra_string_2 ;;
  }

  dimension: extra_text_1 {
    type: string
    sql: ${TABLE}.extra_text_1 ;;
  }

  dimension_group: extra_timestamp_1 {
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
    sql: ${TABLE}.extra_timestamp_1 ;;
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}.full_name ;;
  }

  dimension: hacker_id {
    type: number
    sql: ${TABLE}.hacker_id ;;
  }

  dimension: hr_sourced_candidate {
    type: number
    sql: ${TABLE}.hr_sourced_candidate ;;
  }

  dimension: invite_email_done {
    type: number
    sql: ${TABLE}.invite_email_done ;;
  }

  dimension: invite_valid {
    type: number
    value_format_name: id
    sql: ${TABLE}.invite_valid ;;
  }

  dimension_group: invite_valid_from {
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
    sql: ${TABLE}.invite_valid_from ;;
  }

  dimension_group: invite_valid_to {
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
    sql: ${TABLE}.invite_valid_to ;;
  }

  dimension_group: invited {
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
    sql: ${TABLE}.invited_on ;;
  }

  dimension: qualified {
    type: number
    sql: ${TABLE}.qualified ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.score ;;
  }

  dimension_group: start {
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
    sql: ${TABLE}.start_time ;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}.status ;;
  }

  dimension: test_done {
    type: number
    sql: ${TABLE}.test_done ;;
  }

  dimension: test_id {
    type: number
    sql: ${TABLE}.test_id ;;
  }

  dimension: test_user_id {
    type: number
    sql: ${TABLE}.test_user_id ;;
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

  dimension: user_id {
    type: number
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id, full_name]
  }
}
