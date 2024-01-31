view: recruit_candidates {
  sql_table_name: recruit.recruit_candidates ;;

  dimension: active {
    type: number
    sql: ${TABLE}.active ;;
  }

  dimension: ats_state {
    type: number
    sql: ${TABLE}.ats_state ;;
  }

  dimension: company_id {
    type: number
    sql: ${TABLE}.company_id ;;
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

  dimension: custom_state {
    type: number
    sql: ${TABLE}.custom_state ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: entity_id {
    type: number
    sql: ${TABLE}.entity_id ;;
  }

  dimension: entity_type {
    type: number
    sql: ${TABLE}.entity_type ;;
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

  dimension: hacker_id {
    type: number
    sql: ${TABLE}.hacker_id ;;
  }

  dimension: hr_sourced_candidate {
    type: number
    sql: ${TABLE}.hr_sourced_candidate ;;
  }

  dimension_group: last_activity {
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
    sql: ${TABLE}.last_activity_at ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: state {
    type: number
    sql: ${TABLE}.state ;;
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

  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }

  measure: count {
    type: count
    drill_fields: [name]
  }
}
