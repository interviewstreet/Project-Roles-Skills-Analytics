view: fact_rs_roles {
  sql_table_name:recruit_rs_replica.global.fact_rs_roles ;;

  dimension: companyid {
    type: number
    value_format_name: id
    sql: ${TABLE}.companyid ;;
  }

  dimension: role_cloned_from {
    type: number
    sql: ${TABLE}.role_cloned_from ;;
  }

  dimension: role_company_id {
    type: number
    sql: ${TABLE}.role_company_id ;;
  }

  dimension_group: role_created {
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
    sql: ${TABLE}.role_created_at ;;
  }

  dimension: role_id {
    type: number
    sql: ${TABLE}.role_id ;;
  }

  dimension: role_name {
    type: string
    sql: ${TABLE}.role_name ;;
  }

  dimension: role_priority {
    type: number
    sql: ${TABLE}.role_priority ;;
  }

  dimension: role_standard {
    type: number
    sql: ${TABLE}.role_standard ;;
  }

  dimension: role_state {
    type: number
    sql: ${TABLE}.role_state ;;
  }

  dimension: role_test_type {
    type: number
    sql: ${TABLE}.role_test_type ;;
  }

  dimension: role_unique_id {
    type: string
    sql: ${TABLE}.role_unique_id ;;
  }

  dimension_group: role_updated {
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
    sql: ${TABLE}.role_updated_at ;;
  }

  dimension: role_user_id {
    type: number
    sql: ${TABLE}.role_user_id ;;
  }

  dimension: role_user_name {
    type: string
    sql: ${TABLE}.role_user_name ;;
  }

  measure: count {
    type: count
    drill_fields: [role_name, role_user_name]
  }
}
