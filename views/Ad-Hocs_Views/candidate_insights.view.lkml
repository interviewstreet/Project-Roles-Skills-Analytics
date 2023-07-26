#X# Conversion failed: failed to parse YAML.  Check for pipes on newlines


view: candidate_insights {
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
      recruit_attempts.full_name  AS "recruit_attempts.full_name",
      recruit_attempts.scaled_percentage_score  AS "recruit_attempts.scaled_percentage_score",
      recruit_attempts.email  AS "recruit_attempts.email",
      recruit_attempt_data.aid  AS "recruit_attempt_data.aid",
      recruit_tests.id as "recruit_tests.id",
      max(case when recruit_attempt_data.key = 'gender' then recruit_attempt_data.value end) as Gender,
      max(case when recruit_attempt_data.key = 'gpa' then recruit_attempt_data.value end) as Gpa,
      max(case when recruit_attempt_data.key = 'univ' then recruit_attempt_data.value end) as Univ,
      max(case when recruit_attempt_data.key = 'major' then recruit_attempt_data.value end) as Major,
      max(case when recruit_attempt_data.key = 'year_of_graduation' then recruit_attempt_data.value end) as Year_of_graduation,
      max(case when recruit_attempt_data.key = 'coding_details' then recruit_attempt_data.value end) as Coding_details


      FROM ever_paid_companies_inc_tcs
      INNER JOIN recruit.recruit_tests  AS recruit_tests ON ever_paid_companies_inc_tcs.company_id = abs(recruit_tests.company_id)
      INNER JOIN recruit.recruit_attempts  AS recruit_attempts ON abs(recruit_tests.id) = abs(recruit_attempts.tid)
      LEFT JOIN recruit.recruit_attempt_data  AS recruit_attempt_data ON recruit_attempts.id = recruit_attempt_data.aid
      WHERE (recruit_tests.draft = 0
      and recruit_tests.state <> 3  AND recruit_attempts.tid > 0
      and lower(recruit_attempts.email) not like '%@hackerrank.com%'
      and lower(recruit_attempts.email) not like '%@hackerrank.net%'
      and lower(recruit_attempts.email) not like '%@interviewstreet.com%'
      and lower(recruit_attempts.email) not like '%sandbox17e2d93e4afe44ea889d89aadf6d413f.mailgun.org%'
      and lower(recruit_attempts.email) not like '%strongqa.com%'
      and recruit_attempts.status =  7 )
      GROUP BY
      1,
      2,
      3,
      4,
      5
      ORDER BY
      2 DESC
      LIMIT 50 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: full_name {
    type: string
    sql: ${TABLE}."recruit_attempts.full_name" ;;
  }

  dimension: percentage_score {
    type: number
    sql: ${TABLE}."recruit_attempts.scaled_percentage_score" ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}."recruit_attempts.email" ;;
  }

  dimension: attempt_id {
    type: number
    sql: ${TABLE}."recruit_attempt_data.aid" ;;
  }

  dimension: test_id {
    type: number
    sql: ${TABLE}."recruit_tests.id" ;;
  }

  dimension: gender {
    type: string
    sql: ${TABLE}.gender ;;
  }

  dimension: gpa {
    type: string
    sql: ${TABLE}.gpa ;;
  }

  dimension: univ {
    type: string
    sql: ${TABLE}.univ ;;
  }

  dimension: major {
    type: string
    sql: ${TABLE}.major ;;
  }

  dimension: year_of_graduation {
    type: string
    sql: ${TABLE}.year_of_graduation ;;
  }

  dimension: coding_details {
    type: string
    sql: ${TABLE}.coding_details ;;
  }

  set: detail {
    fields: [
      full_name,
      percentage_score,
      email,
      attempt_id,
      test_id,
      gender,
      gpa,
      univ,
      major,
      year_of_graduation,
      coding_details
    ]
  }
}
