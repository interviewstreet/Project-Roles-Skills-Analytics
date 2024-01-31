view: recruit_interviews {
  sql_table_name: recruit.recruit_interviews ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: access_code {
    type: string
    sql: ${TABLE}.access_code ;;
  }

  dimension: archived {
    type: number
    sql: ${TABLE}.archived ;;
  }

  dimension: ats_application_id {
    type: number
    sql: ${TABLE}.ats_application_id ;;
  }

  dimension: ats_candidate_id {
    type: string
    sql: ${TABLE}.ats_candidate_id ;;
  }

  dimension: ats_id {
    type: number
    sql: ${TABLE}.ats_id ;;
  }

  dimension: auth_key {
    type: string
    sql: ${TABLE}.auth_key ;;
  }

  dimension: candidate_url {
    type: string
    sql: ${TABLE}.candidate_url ;;
  }

  dimension: company_id {
    type: number
    sql: ${TABLE}.company_id ;;
  }

  dimension: company_share {
    type: number
    sql: ${TABLE}.company_share ;;
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

  dimension: current_status {
    type: number
    sql: ${TABLE}.current_status ;;
  }

  dimension_group: ended {
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
    sql: ${TABLE}.ended_at ;;
  }

  dimension: feedback {
    type: string
    sql: ${TABLE}.feedback ;;
  }

  dimension: feedback_mail_sent {
    type: number
    sql: ${TABLE}.feedback_mail_sent ;;
  }

  dimension_group: feedback_mail_sent {
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
    sql: ${TABLE}.feedback_mail_sent_at ;;
  }

  dimension_group: from {
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
    sql: ${TABLE}."from" ;;
  }

  dimension: h {
    type: string
    sql: ${TABLE}.h ;;
  }

  dimension: interviewer_url {
    type: string
    sql: ${TABLE}.interviewer_url ;;
  }

  dimension: metadata {
    type: string
    sql: ${TABLE}.metadata ;;
  }

  dimension: notes {
    type: string
    sql: ${TABLE}.notes ;;
  }

  dimension: paperurl {
    type: string
    sql: ${TABLE}.paperurl ;;
  }

  dimension: quickpad {
    type: number
    sql: ${TABLE}.quickpad ;;
  }

  dimension: resume {
    type: string
    sql: ${TABLE}.resume ;;
  }

  dimension_group: resumed {
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
    sql: ${TABLE}.resumed_at ;;
  }

  dimension_group: started {
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
    sql: ${TABLE}.started_at ;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}.status ;;
  }

  dimension: thumbs {
    type: number
    sql: ${TABLE}.thumbs ;;
  }

  dimension: timezone {
    type: string
    sql: ${TABLE}.timezone ;;
  }

  dimension: title {
    type: string
    sql: ${TABLE}.title ;;
  }

  dimension_group: to {
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
    sql: ${TABLE}."to" ;;
  }

  dimension: typ {
    type: string
    sql: ${TABLE}.typ ;;
  }

  dimension: unique_id {
    type: string
    sql: ${TABLE}.unique_id ;;
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
    drill_fields: [id]
  }
}
