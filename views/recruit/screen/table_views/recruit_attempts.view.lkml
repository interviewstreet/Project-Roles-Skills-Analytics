view: recruit_attempts {
  sql_table_name: recruit.recruit_attempts ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: aasm_state {
    type: number
    sql: ${TABLE}.aasm_state ;;
  }

  dimension: active {
    type: number
    sql: ${TABLE}.active ;;
  }

  dimension: ats_state {
    type: number
    sql: ${TABLE}.ats_state ;;
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

  dimension_group: endtime {
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
    sql: ${TABLE}.endtime ;;
  }

  dimension: extra_string1 {
    type: string
    sql: ${TABLE}.extra_string1 ;;
  }

  dimension: extra_string2 {
    type: string
    sql: ${TABLE}.extra_string2 ;;
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

  dimension: scaled_percentage_score {
    type: number
    sql: ${TABLE}.scaled_percentage_score ;;
  }

  dimension: percentage_score {
    type: number
    sql: ${TABLE}.scaled_percentage_score/100 ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.score ;;
  }

  dimension_group: starttime {
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
    sql: ${TABLE}.starttime ;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}.status ;;
  }

  dimension: test_done {
    type: number
    sql: ${TABLE}.test_done ;;
  }

  dimension: tid {
    type: number
    value_format_name: id
    sql: ${TABLE}.tid ;;
  }

  dimension: attempt_duration {
    type: number
    sql: datediff('minutes',${TABLE}.starttime,${TABLE}.endtime) ;;
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
    drill_fields: [id, full_name]
  }
}
