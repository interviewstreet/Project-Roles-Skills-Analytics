
view: hcl_adhoc {
  # parameter: test_id_filter {
  #   type: number

  # }
derived_table: {
    sql: with question_data_1 as (
          select aid as attempt_id, split_to_array(rad.value, ',') as question_list
          from
          (select * from recruit_rs_replica.recruit.recruit_attempts
           where tid in (select id from recruit_rs_replica.recruit.recruit_tests rt
                         where rt.company_id = 294913 )
          ) ra
          inner join recruit_rs_replica.recruit.recruit_attempt_data rad
          on ra.id = rad.aid where rad.key = 'question_id_scores'
          ),

      test_question_data_1 as (
          select attempt_id,
                 replace(replace(replace(question_list::varchar, '"', ''),'{',''),'}','') as question_id
          from question_data_1 qd,
               qd.question_list question_list
               group by 1,2
          ),

      question_scores_data as (
          SELECT attempt_id,
               CASE
                   WHEN POSITION(':' IN question_id) > 0
                   THEN SUBSTRING(question_id FROM 1 FOR POSITION(':' IN question_id) - 1)
                   ELSE NULL
               END AS question_id,
               cq.type AS question_type,
               CASE
                   WHEN POSITION(':' IN question_id) > 0
                   THEN SUBSTRING(question_id FROM POSITION(':' IN question_id) + 1)
                   ELSE NULL
               END AS question_score
        FROM test_question_data_1 tqd1
        INNER JOIN content_rs_replica.content.questions cq
        ON CASE
               WHEN POSITION(':' IN tqd1.question_id) > 0
               THEN SUBSTRING(tqd1.question_id FROM 1 FOR POSITION(':' IN tqd1.question_id) - 1)
               ELSE NULL
           END = cq.id::nvarchar
          ),

      question_data_2 as (
          select aid as attempt_id, split_to_array(rad.value, ',') as question_list
          from
          (select * from recruit_rs_replica.recruit.recruit_attempts
           where tid in (select id from recruit_rs_replica.recruit.recruit_tests rt
                         where rt.company_id = 294913 )
          ) ra
          inner join recruit_rs_replica.recruit.recruit_attempt_data rad
          on ra.id = rad.aid where rad.key = 'scores_individual_split'
          ),

      test_question_data_2 as (
          select attempt_id,
                 replace(replace(replace(question_list::varchar, '"', ''),'{',''),'}','') as question_id
          from question_data_2 qd,
               qd.question_list question_list
               group by 1,2
          ),

      candidate_scores_data as (
          SELECT attempt_id,
               CASE
                   WHEN POSITION(':' IN question_id) > 0
                   THEN SUBSTRING(question_id FROM 1 FOR POSITION(':' IN question_id) - 1)
                   ELSE NULL
               END AS question_id,
               CASE
                   WHEN POSITION(':' IN question_id) > 0
                   THEN SUBSTRING(question_id FROM POSITION(':' IN question_id) + 1)
                   ELSE NULL
               END AS candidate_score
        FROM test_question_data_2
        WHERE question_id NOT IN ('')
          ),

      question_data_3 as (
          select aid as attempt_id, split_to_array(rad.value, ',') as question_list
          from
          (select * from recruit_rs_replica.recruit.recruit_attempts
           where tid in (select id from recruit_rs_replica.recruit.recruit_tests rt
                         where rt.company_id = 294913 )
          ) ra
          inner join recruit_rs_replica.recruit.recruit_attempt_data rad
          on ra.id = rad.aid where rad.key = 'time_questions_split'
          ),

      test_question_data_3 as (
          select attempt_id,
                 replace(replace(replace(question_list::varchar, '"', ''),'{',''),'}','') as question_id
          from question_data_3 qd,
               qd.question_list question_list
               group by 1,2
          ),

      candidate_time_data as (
          SELECT attempt_id,
               CASE
                   WHEN POSITION(':' IN question_id) > 0
                   THEN SUBSTRING(question_id FROM 1 FOR POSITION(':' IN question_id) - 1)
                   ELSE NULL
               END AS question_id,
               CASE
                   WHEN POSITION(':' IN question_id) > 0
                   THEN SUBSTRING(question_id FROM POSITION(':' IN question_id) + 1)
                   ELSE NULL
               END AS candidate_time
        FROM test_question_data_3
        WHERE question_id NOT IN ('')
      )

      select
      rtc.email as "candidate_email",
      rtc.full_name as "candidate_name",
      rtc.user_id as "invited_by_user_id",
      ru.email as "invited_by_user_email",
      rtc.test_id as "test_id",
      rt.name as "latest_test_name",
      ra.id as "attempt_id",
      ra.starttime as "attempt_starttime",
      ra.endtime as "attempt_endtime",
      datediff(second, ra.starttime, ra.endtime) as "attempt_duration_seconds",
      rad1.value as "out_of_window_events",
      rad2.value as "out_of_window_duration",
      'https://www.hackerrank.com/x/tests/' || rt.id || '/candidates/' || ra.id || '/report/?authkey=4bba542f9205de2aaa79f08109ce138c'
      as "detailed_report_url",
      -- case when ra.scaled_percentage_score != 0 then ra.score/(ra.scaled_percentage_score*1.00) end as max_score,
      rad0.value as "max_score",
      ra.score as "score",
      '' as "cutoff_score", -- this is at a test level and cannot be consumed
      ra.scaled_percentage_score*1.00/100 as "perc_score",
      rad4.value as "network_disconnected_time",
      rad3.value as "copy_paste_frequency",
      rad5.value as "attempt_plagiarism",
      rad10.value as "years_of_experience",
      json_extract_path_text(rad11.value, 'suspicion_category', true) as "suspicion_category",
      qsd.question_id as question_id,
      qsd.question_type as question_type,
      qsd.question_score as question_score,
      max(csd.candidate_score) as "candidate_score",
      max(ctd.candidate_time) as "candidate_time"

      from
      recruit_rs_replica.recruit.recruit_test_candidates  rtc
      left join recruit_rs_replica.recruit.recruit_tests rt
      on rtc.test_id = rt.id
      left join recruit_rs_replica.recruit.recruit_users ru
      on ru.id = rtc.user_id
      left join recruit_rs_replica.recruit.recruit_attempts ra
      on rt.id = ra.tid and rtc.attempt_id = ra.id
      left join (select * from recruit_rs_replica.recruit.recruit_attempt_data
                 where key = 'original_max_score') rad0
                 on rad0.aid = ra.id
      left join (select * from recruit_rs_replica.recruit.recruit_attempt_data
                 where key = 'out_of_window_events') rad1
                 on rad1.aid = ra.id
      left join (select * from recruit_rs_replica.recruit.recruit_attempt_data
                 where key = 'out_of_window_duration') rad2
                 on rad2.aid = ra.id
      left join (select * from recruit_rs_replica.recruit.recruit_attempt_data
                 where key = 'editor_paste_count') rad3
                 on rad3.aid = ra.id
      left join (select * from recruit_rs_replica.recruit.recruit_attempt_data
                 where key = 'disconnected_time') rad4
                 on rad4.aid = ra.id
      left join (select * from recruit_rs_replica.recruit.recruit_attempt_data
                where key = 'enable_advanced_proctoring') rad5
                on rad5.aid = ra.id
      left join question_scores_data qsd on qsd.attempt_id = ra.id
      left join candidate_scores_data csd on csd.attempt_id = ra.id
      left join candidate_time_data ctd on ctd.attempt_id = ra.id
      left join (select * from recruit_rs_replica.recruit.recruit_attempt_data
                where key = 'years_experience') rad10
                on rad10.aid = ra.id
      left join (select * from recruit_rs_replica.recruit.recruit_attempt_data
                where key = 'ml_plagiarism_report') rad11
                on rad11.aid = ra.id

      GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }



  dimension: candidate_email {
    type: string
    sql: ${TABLE}.candidate_email ;;
  }

  dimension: candidate_name {
    type: string
    sql: ${TABLE}.candidate_name ;;
  }

  dimension: invited_by_user_id {
    type: number
    sql: ${TABLE}.invited_by_user_id ;;
  }

  dimension: invited_by_user_email {
    type: string
    sql: ${TABLE}.invited_by_user_email ;;
  }

  dimension: test_id {
    type: number
    sql: ${TABLE}.test_id ;;
  }

  dimension: latest_test_name {
    type: string
    sql: ${TABLE}.latest_test_name ;;
  }

  dimension: attempt_id {
    type: number
    sql: ${TABLE}.attempt_id ;;
  }

  dimension_group: attempt_starttime {
    type: time
    sql: ${TABLE}.attempt_starttime ;;
  }

  dimension_group: attempt_endtime {
    type: time
    sql: ${TABLE}.attempt_endtime ;;
  }

  dimension: attempt_duration_seconds {
    type: number
    sql: ${TABLE}.attempt_duration_seconds ;;
  }

  dimension: out_of_window_events {
    type: string
    sql: ${TABLE}.out_of_window_events ;;
  }

  dimension: out_of_window_duration {
    type: string
    sql: ${TABLE}.out_of_window_duration ;;
  }

  dimension: detailed_report_url {
    type: string
    sql: ${TABLE}.detailed_report_url ;;
  }

  dimension: max_score {
    type: string
    sql: ${TABLE}.max_score ;;
  }

  dimension: score {
    type: number
    sql: ${TABLE}.score ;;
  }

  dimension: cutoff_score {
    type: string
    sql: ${TABLE}.cutoff_score ;;
  }

  dimension: perc_score {
    type: number
    sql: ${TABLE}.perc_score ;;
  }

  dimension: network_disconnected_time {
    type: string
    sql: ${TABLE}.network_disconnected_time ;;
  }

  dimension: copy_paste_frequency {
    type: string
    sql: ${TABLE}.copy_paste_frequency ;;
  }

  dimension: attempt_plagiarism {
    type: string
    sql: ${TABLE}.attempt_plagiarism ;;
  }

  dimension: years_of_experience {
    type: string
    sql: ${TABLE}.years_of_experience ;;
  }

  dimension: suspicion_category {
    type: string
    sql: ${TABLE}.suspicion_category ;;
  }

  dimension: question_id {
    type: string
    sql: ${TABLE}.question_id ;;
  }

  dimension: question_type {
    type: string
    sql: ${TABLE}.question_type ;;
  }

  measure: question_score {
    type: max
    sql: ${TABLE}.question_score ;;
  }

  measure: candidate_score {
    type: max
    sql: ${TABLE}.candidate_score ;;
  }

  measure: candidate_time {
    type: max
    sql: ${TABLE}.candidate_time ;;
  }

  measure: question_percentage_score {
    type: number
    sql: round(${candidate_score}/${question_score},1) ;;
  }

  set: detail {
    fields: [
      candidate_email,
      candidate_name,
      invited_by_user_id,
      invited_by_user_email,
      test_id,
      latest_test_name,
      attempt_id,
      attempt_starttime_time,
      attempt_endtime_time,
      attempt_duration_seconds,
      out_of_window_events,
      out_of_window_duration,
      detailed_report_url,
      max_score,
      score,
      cutoff_score,
      perc_score,
      network_disconnected_time,
      copy_paste_frequency,
      attempt_plagiarism,
      years_of_experience,
      suspicion_category,
      question_id,
      question_type,
      question_score,
      candidate_score,
      candidate_time
    ]
  }
}
