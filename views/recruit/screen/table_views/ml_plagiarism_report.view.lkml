view: ml_plagiarism_report {
    sql_table_name: recruit.recruit_attempt_data ;;
    drill_fields: [id]

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}.id ;;
    }
    dimension: aid {
      type: number
      value_format_name: id
      sql: ${TABLE}.aid ;;
    }

  dimension: suspicion_category {
    type: string
    sql: json_extract_path_text(ml_plagiarism_report.value, 'suspicion_category', true) ;;
  }


    dimension_group: created {
      type: time
      timeframes: [raw, time, date, week, month, quarter, year]
      sql: ${TABLE}.created_at ;;
    }
    dimension: key {
      type: string
      sql: ${TABLE}.key ;;
    }
    dimension_group: updated {
      type: time
      timeframes: [raw, time, date, week, month, quarter, year]
      sql: ${TABLE}.updated_at ;;
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
