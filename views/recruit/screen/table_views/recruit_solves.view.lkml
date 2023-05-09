view: recruit_solves {
  sql_table_name: recruit.recruit_solves ;;
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

  dimension: answer {
    type: string
    sql: ${TABLE}.answer ;;
  }

  dimension: bonusscore {
    type: number
    sql: ${TABLE}.bonusscore ;;
  }

  dimension: language_solved {
    type: string
    sql: case WHEN  json_extract_path_text(${metadata}, 'language') = 'java' THEN 'Java'
              WHEN  json_extract_path_text(${metadata}, 'language') = 'java15' THEN 'Java'
              WHEN  json_extract_path_text(${metadata}, 'language') = 'java8' THEN 'Java'
              WHEN  json_extract_path_text(${metadata}, 'language') = 'pypy' THEN 'Python'
              WHEN  json_extract_path_text(${metadata}, 'language') = 'pypy3' THEN 'Python'
              WHEN  json_extract_path_text(${metadata}, 'language') = 'python' THEN 'Python'
              WHEN  json_extract_path_text(${metadata}, 'language') = 'python3' THEN 'Python'
              WHEN  json_extract_path_text(${metadata}, 'language') = 'cpp' THEN 'C++'
              WHEN  json_extract_path_text(${metadata}, 'language') = 'cpp14' THEN 'C++'
              WHEN  json_extract_path_text(${metadata}, 'language') = 'cpp20' THEN 'C++'
              WHEN  json_extract_path_text(${metadata}, 'language') = 'csharp' THEN 'Csharp/.NET'
              else 'Others'
              end;;

  }

  dimension: frames {
    type: string
    sql: ${TABLE}.frames ;;
  }

  dimension_group: inserttime {
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
    sql: ${TABLE}.inserttime ;;
  }

  dimension: metadata {
    type: string
    sql: ${TABLE}.metadata ;;
  }

  dimension: processed {
    type: number
    sql: ${TABLE}.processed ;;
  }

  dimension: qid {
    type: number
    value_format_name: id
    sql: ${TABLE}.qid ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.score ;;
  }

  dimension: max_score {
    type: number
    sql: json_extract_path_text(${TABLE}.metadata,'max_score',true);;
  }

  dimension: percentage {
    type: number
    sql: ${score}*100.0/cast(${max_score}*1.0 as DOUBLE PRECISION);;
  }

  dimension: Score_Bucket {
    type: string
    sql: case
          when ${percentage} >=0 and ${percentage} <=50 then '0-50'
          when ${percentage} >50 and ${percentage} <=75 then '50-75'
          when ${percentage} >75 and ${percentage} <=90 then '75-90'
          else '90-100' end;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}.status ;;
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

  measure: count {
    type: count
    drill_fields: [id]
  }
}
