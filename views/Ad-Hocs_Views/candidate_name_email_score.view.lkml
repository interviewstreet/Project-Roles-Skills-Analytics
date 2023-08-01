#X# Conversion failed: failed to parse YAML.  Check for pipes on newlines


view: candidate_name_email_score {
  derived_table: {
    sql: WITH ever_paid_companies_inc_tcs AS (---- Ever Paid Customers | TCS LND/ Internal accounts Excluded
                with ever_paid as
                (

      select distinct company_plan_changelog_company_id as company_id from global.fact_recruit_company_plan_changelog
      where company_plan_changelog_plan_name not in ('free', 'trial', 'user-freemium-interviews-v1','locked') -- # ever paid customers (This table has data only of companies created post 2018)
      ---- ^ Above query returns ever paid customer who joined 2018 onwards
      union
      select distinct company_id from global.dim_recruit_company rc
      where company_stripe_plan not in ('free', 'trial','user-freemium-interviews-v1','locked')
      and company_type not in ('free', 'trial','locked')  -- # using this logic to cover paid customers who are not covered in the above logic [company_plan_changelog table]

      ---- ^ currently active customers being missed out on prev query (2018 onwards set)
      )

      Select rc.*
      from
      global.dim_recruit_company rc  inner join ever_paid ep on ep.company_id=rc.company_id

      inner join global.dim_recruit_user ru on ru.user_id=rc.company_owner  ---- filter internal test accounts created by HR users themselves
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
      recruit_tests.company_id as company_id,
      recruit_tests.id as test_id,
      recruit_attempts.id  AS attempt_id,
      ru.firstname as firstname,
      ru.lastname as lastname,
      recruit_attempts.email  AS email,
      ru1.email as user_email,
      recruit_attempts.scaled_percentage_score/100  AS score_percentage
      FROM ever_paid_companies_inc_tcs
      INNER JOIN recruit.recruit_tests  AS recruit_tests ON ever_paid_companies_inc_tcs.company_id = abs(recruit_tests.company_id)
      INNER JOIN recruit.recruit_attempts  AS recruit_attempts ON abs(recruit_tests.id) = abs(recruit_attempts.tid)
      left join recruit.recruit_users ru
      on ru.email = recruit_attempts.email
      left join recruit.recruit_test_candidates rtc
      on rtc.attempt_id = recruit_attempts.id
      left join recruit.recruit_users ru1
      on ru1.id = rtc.user_id
      WHERE (recruit_tests.draft = 0
      and recruit_tests.state <> 3  AND recruit_attempts.tid > 0
      and lower(recruit_attempts.email) not like '%@hackerrank.com%'
      and lower(recruit_attempts.email) not like '%@hackerrank.net%'
      and lower(recruit_attempts.email) not like '%@interviewstreet.com%'
      and lower(recruit_attempts.email) not like '%sandbox17e2d93e4afe44ea889d89aadf6d413f.mailgun.org%'
      and lower(recruit_attempts.email) not like '%strongqa.com%'
      and recruit_attempts.status =  7 ) ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: test_id {
    type: number
    sql: ${TABLE}.test_id ;;
  }

  dimension: company_id {
    type: number
    sql: ${TABLE}.company_id ;;
  }

  dimension: attempt_id {
    type: number
    sql: ${TABLE}.attempt_id ;;
  }

  dimension: first_name {
    type: string
    sql: ${TABLE}.firstname ;;
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.lastname ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: user_email {
    type: string
    sql: ${TABLE}.user_email ;;
  }

  dimension: score_percentage {
    type: number
    sql: ${TABLE}.score_percentage ;;
  }

  set: detail {
    fields: [
      test_id,
      attempt_id,
      email,
      user_email,
      score_percentage
    ]
  }
}
