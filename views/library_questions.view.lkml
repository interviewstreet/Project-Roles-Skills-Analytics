view: library_questions {
      derived_table: {
      sql: select DISTINCT json_extract_array_element_text(rl.questions, seq.rn) as qid, rl.id as lib_id
            from recruit_rs_replica.recruit.recruit_library as rl,(select row_number() OVER (order by true)::integer - 1 as rn
            from  content_rs_replica.content.questions limit 10000) as seq
            where seq.rn < JSON_ARRAY_LENGTH(rl.questions)
            and id IN (1,2,3,110,162,166,383,990)
            order by 1 ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: qid {
      type: string
      sql: ${TABLE}.qid ;;
    }

    dimension: lib_id {
      type: number
      sql: ${TABLE}.lib_id ;;
    }

    set: detail {
      fields: [
        qid,
        lib_id
      ]
    }
  }
