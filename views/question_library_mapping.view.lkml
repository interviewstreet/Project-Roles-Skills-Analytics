view: question_library_mapping {
    derived_table: {
      sql: with lib_qstn as
              (select DISTINCT json_extract_array_element_text(rl.questions, seq.rn) as qid, rl.id as library
                    from recruit_rs_replica.recruit.recruit_library as rl,(select row_number() OVER (order by true)::integer - 1 as rn
                    from  content_rs_replica.content.questions limit 10000) as seq
                    where seq.rn < JSON_ARRAY_LENGTH(rl.questions)
                    and id IN (1,2,3,110,162,166,383,921)
              )

              select qid,library,type
              from
              lib_qstn
              inner join
              content_rs_replica.content.questions cq on cq.id = lib_qstn.qid
              where
              cq.id = 676181 ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: qid {
      type: number
      sql: ${TABLE}.qid ;;
    }

    dimension: library {
      type: number
      sql: ${TABLE}.library ;;
    }

    dimension: type {
      type: string
      sql: ${TABLE}.type ;;
    }

    set: detail {
      fields: [
        qid,
        library,
        type
      ]
    }
  }
