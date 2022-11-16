view: recruit_solves {
  sql_table_name: recruit.recruit_solves ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: aid {
    type: number
    value_format_name: id
    sql: ${TABLE}.aid ;;
  }

  dimension: answer {
    type: string
    sql: ${TABLE}.answer ;;
  }

  dimension: bonusscore {
    type: number
    sql: ${TABLE}.bonusscore ;;
  }

  dimension: frames {
    type: string
    sql: ${TABLE}.frames ;;
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

  dimension: metadata {
    type: string
    sql: ${TABLE}.metadata ;;
  }

  dimension: processed {
    type: number
    sql: ${TABLE}.processed ;;
  }

  dimension: qid {
    type: number
    value_format_name: id
    sql: ${TABLE}.qid ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.score ;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}.status ;;
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
