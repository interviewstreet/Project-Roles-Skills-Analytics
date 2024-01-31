
view: attempt_skill_wise_scoring {
  derived_table: {
    sql: -- Select
      -- from recruit.recruit_tests rt
      -- inner join recruit_attempts ra on ra.tid=rt.id


      -- Select * from recruit.recruit_tests
      -- where company_id = 296516


      with
      seq as
      (select (row_number() over (order by 1))::integer  as row_ from recruit_rs_replica.recruit.recruit_subscriptions limit 1000 ) ,
      attempt_questions as
      (
      select
      rt.company_id as company_id,
      rt.id as test_id,
      rt.name as test_name,
      ra.id as attempt_id,
      ra.email,
      frad.value,
      split_part(frad.value,'-',seq.row_)::bigint as Question_id,
      ra.score,
      ra.scaled_percentage_score*1.0 as scaled_percentage_score,
      ra.starttime,
      ra.endtime

      from recruit_rs_replica.recruit.recruit_tests rt
      inner join recruit_rs_replica.recruit.recruit_companies rc on abs(rt.company_id) = rc.id
      inner join recruit_rs_replica.recruit.recruit_attempts ra on ra.tid = rt.id
      and tid > 0  -- This will exclude deleted or re-attempts. Use this or remove based on whether you want to consider deleted or re-attempts or not
      AND ra.status =  7  ---- attempt submitteds
      --and tc.valid=1    -- excludes deleted invites

      inner join recruit_rs_replica.recruit.recruit_attempt_data  frad ON ra.id = (frad.aid) AND frad.key ='questions'

      inner join  seq on seq.row_ <= regexp_count(frad.value, '-')+1

      group by 1,2,3,4,5,6,7,8,9,10,11)

      Select aq.company_id, aq.test_id, aq.attempt_id,aq.test_name,aq.email,
      aq.score as attempt_score,
      aq.scaled_percentage_score*1.0/100.0 as attempt_perc_score,
      aq.starttime,
      aq.endtime,
      date_diff('minutes',aq.starttime,aq.endtime) as Attempt_time_minutes,
      aq.question_id,
      --aq.value,
      cq.name as Question_name,
      json_extract_path_text(json_extract_array_element_text(json_extract_path_text(custom, 'skills_obj',true),0,true),'name',true) as  Skill,
      --frad2.value,
      case when rs.qid is null then 'Not Answered' else 'Answered' end Candidate_Question_status,
      json_extract_path_text(frad2.value, cast(aq.question_id as nvarchar(24) ), true) as Question_time_spent_Seconds,
      rs.score as question_score ,
      dcq.question_points
      --json_extract_path_text(rs.metadata,'max_score',true) as Max_Score


      from
      attempt_questions aq
      inner join recruit_rs_replica.recruit.recruit_attempt_data  frad2 ON aq.attempt_id = (frad2.aid) AND frad2.key ='time_questions_split'
      inner join content_rs_replica.content.questions cq on cq.id=aq.question_id
      left join hr_analytics.global.dim_content_questions dcq on dcq.question_id=cq.id
      left join recruit_rs_replica.recruit.recruit_solves rs on rs.aid=aq.attempt_id and rs.qid=aq.Question_id;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: company_id {
    type: number
    sql: ${TABLE}.company_id ;;
  }

  dimension: test_id {
    type: number
    sql: ${TABLE}.test_id ;;
  }

  dimension: attempt_id {
    type: number
    sql: ${TABLE}.attempt_id ;;
  }

  dimension: test_name {
    type: string
    sql: ${TABLE}.test_name ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: attempt_score {
    type: number
    sql: ${TABLE}.attempt_score ;;
  }

  dimension: attempt_perc_score {
    type: number
    sql: ${TABLE}.attempt_perc_score ;;
  }

  dimension_group: starttime {
    type: time
    sql: ${TABLE}.starttime ;;
  }

  dimension_group: endtime {
    type: time
    sql: ${TABLE}.endtime ;;
  }

  dimension: attempt_time_minutes {
    type: number
    sql: ${TABLE}.attempt_time_minutes ;;
  }

  dimension: question_id {
    type: number
    sql: ${TABLE}.question_id ;;
  }

  dimension: question_name {
    type: string
    sql: ${TABLE}.question_name ;;
  }

  dimension: skill {
    type: string
    sql: ${TABLE}.skill ;;
  }

  dimension: candidate_question_status {
    type: string
    sql: ${TABLE}.candidate_question_status ;;
  }

  dimension: question_time_spent_seconds {
    type: string
    sql: ${TABLE}.question_time_spent_seconds ;;
  }

  dimension: question_score {
    type: number
    sql: ${TABLE}.question_score ;;
  }

  dimension: question_points {
    type: number
    sql: ${TABLE}.question_points ;;
  }

  set: detail {
    fields: [
      company_id,
      test_id,
      attempt_id,
      test_name,
      email,
      attempt_score,
      attempt_perc_score,
      starttime_time,
      endtime_time,
      attempt_time_minutes,
      question_id,
      question_name,
      skill,
      candidate_question_status,
      question_time_spent_seconds,
      question_score,
      question_points
    ]
  }
}
