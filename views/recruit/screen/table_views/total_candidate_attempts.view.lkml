view: total_candidate_attempts {

    derived_table: {
      sql: select ra.tid, ra.email, count(distinct ra.id) as total_attempts
              from
              recruit.recruit_tests rt
              join
              recruit.recruit_attempts ra
              on rt.id = abs(ra.tid)
              group by 1,2 ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

  dimension: tid {
    type: number
    sql: ${TABLE}.tid ;;
  }

    dimension: email {
      type: string
      sql: ${TABLE}.email ;;
    }

    dimension: total_attempts {
      type: number
      sql: ${TABLE}.total_attempts ;;
    }

    set: detail {
      fields: [
        tid,
        email,
        total_attempts
      ]
    }
  }
