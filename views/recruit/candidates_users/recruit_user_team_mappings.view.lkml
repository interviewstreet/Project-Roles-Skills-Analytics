view: recruit_user_team_mappings {
  sql_table_name: recruit.recruit_user_team_mappings ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: candidates_permission {
    type: number
    sql: ${TABLE}.candidates_permission ;;
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

  dimension: interviews_permission {
    type: number
    sql: ${TABLE}.interviews_permission ;;
  }

  dimension: questions_permission {
    type: number
    sql: ${TABLE}.questions_permission ;;
  }

  dimension: team_admin {
    type: number
    sql: ${TABLE}.team_admin ;;
  }

  dimension: team_id {
    type: number
    sql: ${TABLE}.team_id ;;
  }

  dimension: tests_permission {
    type: number
    sql: ${TABLE}.tests_permission ;;
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
