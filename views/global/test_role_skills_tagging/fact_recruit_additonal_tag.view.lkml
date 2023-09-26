view: fact_recruit_additonal_tag {
  sql_table_name:hr_analytics.global.fact_recruit_additonal_tag ;;

  dimension_group: additional_tag_created {
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
    sql: ${TABLE}.additional_tag_created_at ;;
  }

  dimension: additional_tag_created_by {
    type: number
    sql: ${TABLE}.additional_tag_created_by ;;
  }

  dimension: additional_tag_entity_id {
    type: number
    sql: ${TABLE}.additional_tag_entity_id ;;
  }

  dimension: additional_tag_id {
    type: number
    sql: ${TABLE}.additional_tag_id ;;
  }

  dimension: additional_tag_limit {
    type: number
    sql: ${TABLE}.additional_tag_limit ;;
  }

  dimension: additional_tag_type {
    type: string
    sql: ${TABLE}.additional_tag_type ;;
  }

  dimension_group: additional_tag_updated {
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
    sql: ${TABLE}.additional_tag_updated_at ;;
  }

  dimension: additional_tag_usage {
    type: string
    sql: ${TABLE}.additional_tag_usage ;;
  }

  dimension: companyid {
    type: number
    value_format_name: id
    sql: ${TABLE}.companyid ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}