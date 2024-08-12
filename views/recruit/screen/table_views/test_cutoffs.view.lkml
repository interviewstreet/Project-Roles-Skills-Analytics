view: test_cutoffs {
  sql_table_name: recruit.recruit_tests_data ;;
    drill_fields: [id]

    dimension: id {
      primary_key: yes
      type: number
      sql: ${TABLE}.id ;;
    }

    dimension_group: created {
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
      sql: ${TABLE}.created_at ;;
    }

    dimension: key {
      type: string
      sql: ${TABLE}.key ;;
    }

    dimension: tid {
      type: number
      value_format_name: id
      sql: ${TABLE}.tid ;;
    }

    dimension_group: updated {
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
