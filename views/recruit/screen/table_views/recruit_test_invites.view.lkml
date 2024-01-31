view: recruit_test_invites {
  sql_table_name: recruit.recruit_test_invites ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: api_access {
    type: number
    sql: ${TABLE}.api_access ;;
  }

  dimension: ats_candidate_id {
    type: string
    sql: ${TABLE}.ats_candidate_id ;;
  }

  dimension: candidates_data {
    type: string
    sql: ${TABLE}.candidates_data ;;
  }

  dimension: cc {
    type: string
    sql: ${TABLE}.cc ;;
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

  dimension: csv_data {
    type: string
    sql: ${TABLE}.csv_data ;;
  }

  dimension: evaluator_email {
    type: string
    sql: ${TABLE}.evaluator_email ;;
  }

  dimension: force {
    type: number
    sql: ${TABLE}.force ;;
  }

  dimension: invalid_emails {
    type: string
    sql: ${TABLE}.invalid_emails ;;
  }

  dimension: jobvite_application_id {
    type: string
    sql: ${TABLE}.jobvite_application_id ;;
  }

  dimension: message {
    type: string
    sql: ${TABLE}.message ;;
  }

  dimension: metadata {
    type: string
    sql: ${TABLE}.metadata ;;
  }

  dimension: options {
    type: string
    sql: ${TABLE}.options ;;
  }

  dimension: send_email {
    type: number
    sql: ${TABLE}.send_email ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  dimension: subject {
    type: string
    sql: ${TABLE}.subject ;;
  }

  dimension: tags {
    type: string
    sql: ${TABLE}.tags ;;
  }

  dimension: test_finish_url {
    type: string
    sql: ${TABLE}.test_finish_url ;;
  }

  dimension: test_result_url {
    type: string
    sql: ${TABLE}.test_result_url ;;
  }

  dimension: tid {
    type: number
    value_format_name: id
    sql: ${TABLE}.tid ;;
  }

  dimension: timelimits {
    type: string
    sql: ${TABLE}.timelimits ;;
  }

  dimension: uid {
    type: number
    value_format_name: id
    sql: ${TABLE}.uid ;;
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
