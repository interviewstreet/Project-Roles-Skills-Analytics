#X# Conversion failed: failed to parse YAML.  Check for pipes on newlines


view: candidate_insights {
  derived_table: {
    sql: WITH ever_paid_companies_inc_tcs AS (---- Ever Paid Customers | TCS LND/ Internal accounts Excluded
          with ever_paid as
          (

      select distinct company_plan_changelog_company_id as company_id from hr_analytics.global.fact_recruit_company_plan_changelog
      where company_plan_changelog_plan_name not in ('free', 'trial', 'user-freemium-interviews-v1','locked') -- # ever paid customers (This table has data only of companies created post 2018)
      ---- ^ Above query returns ever paid customer who joined 2018 onwards
      union
      select distinct company_id from hr_analytics.global.dim_recruit_company rc
      where company_stripe_plan not in ('free', 'trial','user-freemium-interviews-v1','locked')
      and company_type not in ('free', 'trial','locked')  -- # using this logic to cover paid customers who are not covered in the above logic [company_plan_changelog table]

      ---- ^ currently active customers being missed out on prev query (2018 onwards set)
      )

      Select rc.*
      from
     hr_analytics.global.dim_recruit_company rc  inner join ever_paid ep on ep.company_id=rc.company_id

      inner join hr_analytics.global.dim_recruit_user ru on ru.user_id=rc.company_owner  ---- filter internal test accounts created by HR users themselves
      and lower(ru.user_email) not like '%@hackerrank.com%'
      and lower(ru.user_email) not like '%@hackerrank.net%'
      and lower(ru.user_email) not like '%@interviewstreet.com%'
      and lower(ru.user_email) not like '%sandbox17e2d93e4afe44ea889d89aadf6d413f.mailgun.org%'
      and lower(ru.user_email) not like '%strongqa.com%'

      where lower(company_name) not in ('none', ' ', 'hackerrank','interviewstreet') --- Filter internal accounts based on company names
      and lower(company_name) not like '%hackerrank%'
      and lower(company_name) not like '%hacker%rank%'
      and lower(company_name) not like '%interviewstreet%'
      and lower(company_name) not like '%interview%street%'
      and company_name not like 'Company%'

      and rc.company_id not in (106529,46242) --- exclude internal test setters
      )
      SELECT
--      recruit_attempts.full_name  AS "recruit_attempts.full_name",
      recruit_attempts.scaled_percentage_score/100  AS "recruit_attempts.scaled_percentage_score",
      recruit_attempts.email  AS "recruit_attempts.email",
      recruit_attempts.id  AS "recruit_attempts.id",
      recruit_tests.id as "recruit_tests.id",
--      rtc.user_id as "user_id",
--      ru.email as "user_email",
     -- case when recruit_attempt_data.key = 'gender' then recruit_attempt_data.value end as Gender,
     -- case when recruit_attempt_data.key = 'gpa' then recruit_attempt_data.value end as Gpa,
     -- case when recruit_attempt_data.key = 'univ' then recruit_attempt_data.value end as Univ,
     -- case when recruit_attempt_data.key = 'major' then recruit_attempt_data.value end as Major,
     -- case when recruit_attempt_data.key = 'year_of_graduation' then recruit_attempt_data.value end as Year_of_graduation,
      max(case when recruit_attempt_data.key = 'recruiters_name' then recruit_attempt_data.value end) as recruiters_name

      FROM ever_paid_companies_inc_tcs
      INNER JOIN recruit.recruit_tests  AS recruit_tests ON ever_paid_companies_inc_tcs.company_id = abs(recruit_tests.company_id)
      INNER JOIN recruit.recruit_attempts  AS recruit_attempts ON abs(recruit_tests.id) = abs(recruit_attempts.tid)
      LEFT JOIN recruit.recruit_attempt_data  AS recruit_attempt_data ON recruit_attempts.id = recruit_attempt_data.aid
--      left join recruit.recruit_test_candidates rtc
--      on rtc.attempt_id = recruit_attempts.id
--      left join recruit.recruit_users ru
--      on ru.id = rtc.user_id
      WHERE (recruit_tests.draft = 0
      and recruit_tests.state <> 3  AND recruit_attempts.tid > 0
      and lower(recruit_attempts.email) not like '%@hackerrank.com%'
      and lower(recruit_attempts.email) not like '%@hackerrank.net%'
      and lower(recruit_attempts.email) not like '%@interviewstreet.com%'
      and lower(recruit_attempts.email) not like '%sandbox17e2d93e4afe44ea889d89aadf6d413f.mailgun.org%'
      and lower(recruit_attempts.email) not like '%strongqa.com%'
      and recruit_attempts.status =  7 )
      group by
      1,2,3,4;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  # dimension: full_name {
  #   type: string
  #   sql: ${TABLE}."recruit_attempts.full_name" ;;
  # }

  dimension: percentage_score {
    type: number
    sql: ${TABLE}."recruit_attempts.scaled_percentage_score" ;;
  }

  dimension: candidate_email {
    type: string
    sql: ${TABLE}."recruit_attempts.email" ;;
  }

  # dimension: user_email {
  #   type: string
  #   sql: ${TABLE}."user_email" ;;
  # }

  dimension: attempt_id {
    type: number
    sql: ${TABLE}."recruit_attempts.id" ;;
  }

  dimension: test_id {
    type: number
    sql: ${TABLE}."recruit_tests.id" ;;
  }

  # dimension: user_id {
  #   type: number
  #   sql: ${TABLE}."user_id" ;;
  # }

  # dimension: gender {
  #   type: string
  #   sql: ${TABLE}.gender ;;
  # }

  # dimension: gpa {
  #   type: string
  #   sql: ${TABLE}.gpa ;;
  # }

  # dimension: univ {
  #   type: string
  #   sql: ${TABLE}.univ ;;
  # }

  # dimension: major {
  #   type: string
  #   sql: ${TABLE}.major ;;
  # }

  # dimension: year_of_graduation {
  #   type: string
  #   sql: ${TABLE}.year_of_graduation ;;
  # }

  dimension: recruiters_name {
    type: string
    sql: ${TABLE}.recruiters_name ;;
  }



  set: detail {
    fields: [
      percentage_score,
      candidate_email,
      attempt_id,
      test_id,
      recruiters_name]
  }
}