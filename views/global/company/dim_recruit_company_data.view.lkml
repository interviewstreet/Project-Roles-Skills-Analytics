view: dim_recruit_company_data {
  sql_table_name:hr_analytics.global.dim_recruit_company_data ;;

  dimension: company_data_company_id {
    type: number
    sql: ${TABLE}.company_data_company_id ;;
    drill_fields: [company_data_company_id]
  }

  dimension_group: company_data_created {
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
    sql: ${TABLE}.company_data_created_at ;;
  }

  dimension: company_data_id {
    type: number
    sql: ${TABLE}.company_data_id ;;
  }

  dimension: company_data_key {
    type: string
    sql: ${TABLE}.company_data_key ;;
  }

  dimension_group: company_data_updated {
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
    sql: ${TABLE}.company_data_updated_at ;;
  }

  dimension: company_data_value {
    type: string
    sql: ${TABLE}.company_data_value ;;
  }

  dimension: companyid {
    type: number
    value_format_name: id
    sql: ${TABLE}.companyid ;;
  }

  measure: count {
    type: count
    drill_fields: [company_data_company_id]
  }

  measure: company_id_count {
    type: count_distinct
    sql: ${company_data_company_id} ;;
    drill_fields: [company_data_company_id]
  }
}