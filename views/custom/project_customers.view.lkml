view: project_customers {
  derived_table: {
    sql: select company_id,company_data_created_at, company_data_updated_at, company_data_key, company_data_value
      from
     hr_analytics.global.dim_recruit_company rc
      inner join
     hr_analytics.global.dim_recruit_company_data rcd
      on
      rc.company_id = rcd.company_data_company_id
      where
      company_data_key = 'enable_projects' and company_data_value = 'true'
      order by
      2
       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: company_id {
    type: number
    sql: ${TABLE}.company_id ;;
  }

  dimension_group: company_data_created_at {
    type: time
    sql: ${TABLE}.company_data_created_at ;;
  }

  dimension_group: company_data_updated_at {
    type: time
    sql: ${TABLE}.company_data_updated_at ;;
  }

  dimension: company_data_key {
    type: string
    sql: ${TABLE}.company_data_key ;;
  }

  dimension: company_data_value {
    type: string
    sql: ${TABLE}.company_data_value ;;
  }

  set: detail {
    fields: [company_id, company_data_created_at_time, company_data_updated_at_time, company_data_key, company_data_value]
  }
}