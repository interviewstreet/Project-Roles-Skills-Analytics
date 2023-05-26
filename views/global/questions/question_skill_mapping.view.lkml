view: question_skill_mapping {
    derived_table: {
      sql: with
              questions as
                (SELECT id, json_extract_path_text(custom, 'skills_obj', true) as skills , json_array_length(json_extract_path_text(custom, 'skills_obj', true), true) as no_of_skills
                FROM content_rs_replica.content.questions dcq
                WHERE json_array_length(json_extract_path_text(custom, 'skills_obj', true), true) > 0
                -- json_extract_path_text(custom, 'skills_obj', true) is not null and json_extract_path_text(custom, 'skills_obj', true) != '[]'
                ),
              range_sequence AS
                (
                SELECT 0 AS i UNION ALL
                SELECT 1 UNION ALL
                SELECT 2 UNION ALL
                SELECT 3 UNION ALL
                SELECT 4 UNION ALL
                SELECT 5 UNION ALL
                SELECT 6 UNION ALL
                SELECT 7 UNION ALL
                SELECT 8 UNION ALL
                SELECT 9 UNION ALL
                SELECT 10 UNION ALL
                SELECT 11 UNION ALL
                SELECT 12
                )

        SELECT
        range_sequence.i as i,
        questions.id as question_id,
        skills,
        no_of_skills,
        JSON_EXTRACT_PATH_TEXT(JSON_EXTRACT_ARRAY_ELEMENT_TEXT(questions.skills,range_sequence.i, true),'name', true) as skill_name,
        JSON_EXTRACT_PATH_TEXT(JSON_EXTRACT_ARRAY_ELEMENT_TEXT(questions.skills,range_sequence.i, true),'unique_id', true) as skill_unique_id
        from questions,range_sequence
        where skill_name <> ''
        ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: i {
      type: number
      sql: ${TABLE}.i ;;
    }

    dimension: question_id {
      type: number
      sql: ${TABLE}.id ;;
    }

    dimension: skills {
      type: string
      sql: ${TABLE}.skills ;;
    }

    dimension: no_of_skills {
      type: number
      sql: ${TABLE}.no_of_skills ;;
    }

    dimension: skill_name {
      type: string
      sql: ${TABLE}.skill_name ;;
    }

    dimension: skill_unique_id {
      type: string
      sql: ${TABLE}.skill_unique_id ;;
    }

    set: detail {
      fields: [
        i,
        question_id,
        skills,
        no_of_skills,
        skill_name,
        skill_unique_id
      ]
    }
  }



# view: question_skill_mapping {
#   # Or, you could make this view a derived table, like this:
#   derived_table: {
#     sql: SELECT
#         user_id as user_id
#         , COUNT(*) as lifetime_orders
#         , MAX(orders.created_at) as most_recent_purchase_at
#       FROM orders
#       GROUP BY user_id
#       ;;
#   }
#
#   # Define your dimensions and measures here, like this:
#   dimension: user_id {
#     description: "Unique ID for each user that has ordered"
#     type: number
#     sql: ${TABLE}.user_id ;;
#   }
#
#   dimension: lifetime_orders {
#     description: "The total number of orders for each user"
#     type: number
#     sql: ${TABLE}.lifetime_orders ;;
#   }
#
#   dimension_group: most_recent_purchase {
#     description: "The date when each user last ordered"
#     type: time
#     timeframes: [date, week, month, year]
#     sql: ${TABLE}.most_recent_purchase_at ;;
#   }
#
#   measure: total_lifetime_orders {
#     description: "Use this for counting lifetime orders across many users"
#     type: sum
#     sql: ${lifetime_orders} ;;
#   }
# }
