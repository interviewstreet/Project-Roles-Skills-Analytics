#X# Conversion failed: failed to parse YAML.  Check for pipes on newlines


view: test_level_insights {
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
          recruit_tests.id  AS "recruit_tests.id",
          recruit_tests.name  AS "recruit_tests.name",
          recruit_tests.owner  AS "recruit_tests.owner",
          test_user_owner.email  AS "test_user_owner.email",
          recruit_tests.company_id  AS "recruit_tests.company_id",
              (DATE(CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', recruit_tests.created_at ))) AS "recruit_tests.created_date",
              (DATE(CONVERT_TIMEZONE('UTC', 'America/Los_Angeles', recruit_tests.updated_at ))) AS "recruit_tests.updated_date",
              DATE(max(recruit_attempts.starttime)) as "recruit_tests.last_used_date",
          COUNT(DISTINCT recruit_test_candidates.id) AS "invites",
          COUNT(DISTINCT recruit_attempts.id) AS "attempts",
          (COALESCE(CAST( ( SUM(DISTINCT (CAST(FLOOR(COALESCE( CAST((recruit_attempts.scaled_percentage_score/100) AS DOUBLE PRECISION) ,0)*(1000000*1.0)) AS DECIMAL(38,0))) + CAST(STRTOL(LEFT(MD5(CAST( recruit_attempts.id   AS VARCHAR)),15),16) AS DECIMAL(38,0))* 1.0e8 + CAST(STRTOL(RIGHT(MD5(CAST( recruit_attempts.id   AS VARCHAR)),15),16) AS DECIMAL(38,0)) ) - SUM(DISTINCT CAST(STRTOL(LEFT(MD5(CAST( recruit_attempts.id   AS VARCHAR)),15),16) AS DECIMAL(38,0))* 1.0e8 + CAST(STRTOL(RIGHT(MD5(CAST( recruit_attempts.id   AS VARCHAR)),15),16) AS DECIMAL(38,0))) )  AS DOUBLE PRECISION) / CAST((1000000*1.0) AS DOUBLE PRECISION), 0) / NULLIF(COUNT(DISTINCT CASE WHEN   CAST((recruit_attempts.scaled_percentage_score/100) AS DOUBLE PRECISION)  IS NOT NULL THEN  recruit_attempts.id   ELSE NULL END), 0)) AS "average_of_percentage_score"
      FROM ever_paid_companies_inc_tcs
      INNER JOIN recruit.recruit_tests  AS recruit_tests ON ever_paid_companies_inc_tcs.company_id = abs(recruit_tests.company_id)
      INNER JOIN recruit.recruit_users  AS test_user_owner ON test_user_owner.id = abs(recruit_tests.owner)
      INNER JOIN recruit.recruit_attempts  AS recruit_attempts ON abs(recruit_tests.id) = abs(recruit_attempts.tid)
      LEFT JOIN recruit.recruit_test_candidates  AS recruit_test_candidates ON recruit_test_candidates.test_id = recruit_tests.id
          and recruit_test_candidates.attempt_id = recruit_attempts.id
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
          5,
          6,
          7
      ORDER BY
          6 DESC;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: recruit_tests_id {
    type: number
    sql: ${TABLE}."recruit_tests.id" ;;
  }

  dimension: recruit_tests_name {
    type: string
    sql: ${TABLE}."recruit_tests.name" ;;
  }

  dimension: recruit_tests_company_id {
    type: number
    sql: ${TABLE}."recruit_tests.company_id" ;;
  }

  dimension: recruit_tests_owner {
    type: number
    sql: ${TABLE}."recruit_tests.owner" ;;
  }

  dimension: test_user_owner_email {
    type: string
    sql: ${TABLE}."test_user_owner.email" ;;
  }

  dimension: recruit_tests_created_date {
    type: date
    sql: ${TABLE}."recruit_tests.created_date" ;;
  }

  dimension: recruit_tests_updated_date {
    type: date
    sql: ${TABLE}."recruit_tests.updated_date" ;;
  }

  dimension: recruit_tests_last_used_date {
    type: date
    sql: ${TABLE}."recruit_tests.last_used_date" ;;
  }

  dimension: invites {
    type: number
    sql: ${TABLE}.invites ;;
  }

  dimension: attempts {
    type: number
    sql: ${TABLE}.attempts ;;
  }

  dimension: average_of_percentage_score {
    type: number
    sql: ${TABLE}.average_of_percentage_score ;;
  }

  set: detail {
    fields: [
        recruit_tests_id,
  recruit_tests_name,
  recruit_tests_owner,
  test_user_owner_email,
  recruit_tests_created_date,
  recruit_tests_updated_date,
  recruit_tests_last_used_date,
  invites,
  attempts,
  average_of_percentage_score
    ]
  }
}