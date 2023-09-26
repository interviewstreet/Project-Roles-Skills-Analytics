view: fact_rs_skills {
  sql_table_name:hr_analytics.global.fact_rs_skills ;;

  dimension: companyid {
    type: number
    value_format_name: id
    sql: ${TABLE}.companyid ;;
  }

  dimension: skill_company_id {
    type: number
    sql: ${TABLE}.skill_company_id ;;
  }

  dimension_group: skill_created {
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
    sql: ${TABLE}.skill_created_at ;;
  }

  dimension: skill_description {
    type: string
    sql: ${TABLE}.skill_description ;;
  }

  dimension: skill_id {
    type: number
    sql: ${TABLE}.skill_id ;;
  }

  dimension: skill_logo_url {
    type: string
    sql: ${TABLE}.skill_logo_url ;;
  }

  dimension: skill_name {
    type: string
    sql: ${TABLE}.skill_name ;;
  }

  dimension: skill_slug {
    type: string
    sql: ${TABLE}.skill_slug ;;
  }

  dimension: skill_standard {
    type: number
    sql: ${TABLE}.skill_standard ;;
  }

  dimension: skill_state {
    type: number
    sql: ${TABLE}.skill_state ;;
  }

  dimension: skill_unique_id {
    type: string
    sql: ${TABLE}.skill_unique_id ;;
  }

  dimension_group: skill_updated {
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
    sql: ${TABLE}.skill_updated_at ;;
  }

  dimension: skill_user_id {
    type: number
    sql: ${TABLE}.skill_user_id ;;
  }

  dimension: skill_version_id {
    type: number
    sql: ${TABLE}.skill_version_id ;;
  }

  measure: count {
    type: count
    drill_fields: [skill_name]
  }
}