view: fact_recruit_additonal_tag_mapping {
  sql_table_name:recruit_rs_replica.global.fact_recruit_additonal_tag_mapping ;;

  dimension_group: additional_tag_mapping_created {
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
    sql: ${TABLE}.additional_tag_mapping_created_at ;;
  }

  dimension: additional_tag_mapping_created_by {
    type: number
    sql: ${TABLE}.additional_tag_mapping_created_by ;;
  }

  dimension: additional_tag_mapping_entity_id {
    type: number
    sql: ${TABLE}.additional_tag_mapping_entity_id ;;
  }

  dimension: additional_tag_mapping_id {
    type: number
    sql: ${TABLE}.additional_tag_mapping_id ;;
  }

  dimension: additional_tag_mapping_tag_id {
    type: number
    sql: ${TABLE}.additional_tag_mapping_tag_id ;;
  }

  dimension_group: additional_tag_mapping_updated {
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
    sql: ${TABLE}.additional_tag_mapping_updated_at ;;
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
