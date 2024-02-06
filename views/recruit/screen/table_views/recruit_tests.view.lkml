view: recruit_tests {
  sql_table_name: recruit.recruit_tests ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
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

  dimension: draft {
    type: number
    sql: ${TABLE}.draft ;;
  }

  dimension: duration {
    type: number
    sql: ${TABLE}.duration ;;
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

  dimension: hash {
    type: string
    sql: ${TABLE}.hash ;;
  }

  dimension: instructions {
    type: string
    sql: ${TABLE}.instructions ;;
  }

  dimension: is_questionset {
    type: string
    sql: ${TABLE}.is_questionset ;;
  }

  dimension: locked {
    type: number
    sql: ${TABLE}.locked ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: owner {
    type: number
    sql: ${TABLE}.owner ;;
  }

  dimension: questions {
    type: string
    sql: ${TABLE}.questions ;;
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

  dimension: state {
    type: number
    sql: ${TABLE}.state ;;
  }

  dimension: test_type {
    type: number
    sql: ${TABLE}.test_type ;;
  }

  dimension: tags {
    type: string
    sql: ${TABLE}.tags ;;
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

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
