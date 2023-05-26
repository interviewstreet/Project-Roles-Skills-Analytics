view: fact_rs_role_skill_associations {
  sql_table_name: global.fact_rs_role_skill_associations ;;

  dimension: companyid {
    type: number
    value_format_name: id
    sql: ${TABLE}.companyid ;;
  }

  dimension_group: role_skill_association_created {
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
    sql: ${TABLE}.role_skill_association_created_at ;;
  }

  dimension: role_skill_association_id {
    type: number
    sql: ${TABLE}.role_skill_association_id ;;
  }

  dimension: role_skill_association_role_id {
    type: number
    sql: ${TABLE}.role_skill_association_role_id ;;
  }

  dimension: role_skill_association_skill_id {
    type: number
    sql: ${TABLE}.role_skill_association_skill_id ;;
  }

  dimension: role_skill_association_unique_id {
    type: string
    sql: ${TABLE}.role_skill_association_unique_id ;;
  }

  dimension_group: role_skill_association_updated {
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
    sql: ${TABLE}.role_skill_association_updated_at ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
