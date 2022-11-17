view: fact_recruit_company_plan_changelog {
  sql_table_name: global.fact_recruit_company_plan_changelog ;;

  dimension: company_plan_changelog_company_id {
    type: number
    sql: ${TABLE}.company_plan_changelog_company_id ;;
  }

  dimension_group: company_plan_changelog_created {
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
    sql: ${TABLE}.company_plan_changelog_created_at ;;
  }

  dimension: company_plan_changelog_id {
    type: number
    sql: ${TABLE}.company_plan_changelog_id ;;
  }

  dimension: company_plan_changelog_plan_name {
    type: string
    sql: ${TABLE}.company_plan_changelog_plan_name ;;
  }

  dimension_group: company_plan_changelog_updated {
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
    sql: ${TABLE}.company_plan_changelog_updated_at ;;
  }

  dimension: companyid {
    type: number
    value_format_name: id
    sql: ${TABLE}.companyid ;;
  }

  measure: count {
    type: count
    drill_fields: [company_plan_changelog_plan_name]
  }
}
