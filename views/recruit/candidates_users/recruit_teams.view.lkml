view: recruit_teams {
  sql_table_name: recruit.recruit_teams ;;
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
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_at ;;
  }
  dimension: developer_cap {
    type: number
    sql: ${TABLE}.developer_cap ;;
  }
  dimension: developer_count {
    type: number
    sql: ${TABLE}.developer_count ;;
  }
  dimension: interviewer_cap {
    type: number
    sql: ${TABLE}.interviewer_cap ;;
  }
  dimension: interviewer_count {
    type: number
    sql: ${TABLE}.interviewer_count ;;
  }
  dimension: invite_as {
    type: string
    sql: ${TABLE}.invite_as ;;
  }
  dimension: library_access {
    type: number
    sql: ${TABLE}.library_access ;;
  }
  dimension: logo_id {
    type: number
    sql: ${TABLE}.logo_id ;;
  }
  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }
  dimension: owner {
    type: number
    sql: ${TABLE}.owner ;;
  }
  dimension: recruiter_cap {
    type: number
    sql: ${TABLE}.recruiter_cap ;;
  }
  dimension: recruiter_count {
    type: number
    sql: ${TABLE}.recruiter_count ;;
  }
  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.updated_at ;;
  }
  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
