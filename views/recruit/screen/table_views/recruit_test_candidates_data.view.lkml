view: recruit_test_candidates_data {
  sql_table_name: recruit.recruit_test_candidates_data ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: key {
    type: string
    sql: ${TABLE}.key ;;
  }

  dimension: test_candidate_id {
    type: number
    sql: ${TABLE}.test_candidate_id ;;
  }

  dimension: value {
    type: string
    sql: ${TABLE}.value ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
