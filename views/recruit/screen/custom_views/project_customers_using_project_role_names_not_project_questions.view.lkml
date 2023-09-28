view: project_customers_using_project_role_names_not_project_questions {
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

      select role_name, recruit_tests.company_id , rc.company_name, max(sa.arr_c::decimal) as arr
      from hr_analytics.global.fact_rs_roles frs

      inner join recruit.recruit_additional_tags at on frs.role_unique_id = at."tag"
      and at.tag_type = 4
      and at.taggable_type = 'Recruit::Test'
      --and frs.role_standard = 1
      inner join recruit.recruit_additional_tag_mappings atm on atm.tag_id = at.id
      INNER JOIN recruit.recruit_tests  AS recruit_tests ON atm.eid = recruit_tests.id
      inner join
     hr_analytics.global.dim_recruit_company rc
      on rc.company_id = recruit_tests.company_id
      left join
      hr_analytics.salesforce.accounts sa on sa.hrid_c = rc.company_id
      where
      --role_standard = 0
      --and
      (lower(role_name) like '%develop%' or lower(role_name) like '%scient%' or lower(role_name) like '%analyst%' or lower(role_name) like '%sde%'
      or lower(role_name) like '%analy%' or lower(role_name) like '%engineer%'or lower(role_name) like '%front%' or lower(role_name) like '%back%')
      and recruit_tests.company_id in (
      SELECT
      distinct ever_paid_companies_inc_tcs.company_id  AS "ever_paid_companies_inc_tcs.company_id"
      FROM ever_paid_companies_inc_tcs
      INNER join hr_analytics.global.dim_recruit_company_data  AS dim_recruit_company_data ON ever_paid_companies_inc_tcs.company_id = dim_recruit_company_data.company_data_company_id
      INNER JOIN recruit.recruit_tests  AS recruit_tests ON ever_paid_companies_inc_tcs.company_id = recruit_tests.company_id
      INNER JOIN recruit.recruit_attempts  AS recruit_attempts ON recruit_tests.id = recruit_attempts.tid
      INNER JOIN recruit.recruit_solves  AS recruit_solves ON recruit_attempts.id = recruit_solves.aid
      INNER join hr_analytics.global.dim_content_questions  AS dim_content_questions ON recruit_solves.qid = dim_content_questions.question_id
      LEFT JOIN hr_analytics.salesforce.accounts AS sa on sa.hrid_c = ever_paid_companies_inc_tcs.company_id
      WHERE ((ever_paid_companies_inc_tcs.company_stripe_plan ) <> 'free' AND (ever_paid_companies_inc_tcs.company_stripe_plan ) <> 'locked'
      AND (ever_paid_companies_inc_tcs.company_stripe_plan ) <> 'trial' OR (ever_paid_companies_inc_tcs.company_stripe_plan ) IS NULL)
      AND (dim_recruit_company_data.company_data_key ) = 'enable_projects' AND (dim_recruit_company_data.company_data_value ) = 'true'
      and recruit_tests.draft=0
      and recruit_tests.state <> 3
      and recruit_attempts.tid > 0
      and lower(recruit_attempts.email) not like '%@hackerrank.com%'
      and lower(recruit_attempts.email) not like '%@hackerrank.net%'
      and lower(recruit_attempts.email) not like '%@interviewstreet.com%'
      and lower(recruit_attempts.email) not like '%sandbox17e2d93e4afe44ea889d89aadf6d413f.mailgun.org%'
      and lower(recruit_attempts.email) not like '%strongqa.com%'
      and recruit_attempts.status =  7
      and recruit_solves.aid > 0
      and recruit_solves.status = 2
      AND "ever_paid_companies_inc_tcs.company_id" not in
      (
      SELECT
      distinct ever_paid_companies_inc_tcs.company_id  AS "ever_paid_companies_inc_tcs.company_id"
      FROM ever_paid_companies_inc_tcs
      INNER join hr_analytics.global.dim_recruit_company_data  AS dim_recruit_company_data ON ever_paid_companies_inc_tcs.company_id = dim_recruit_company_data.company_data_company_id
      INNER JOIN recruit.recruit_tests  AS recruit_tests ON ever_paid_companies_inc_tcs.company_id = recruit_tests.company_id
      INNER JOIN recruit.recruit_attempts  AS recruit_attempts ON recruit_tests.id = recruit_attempts.tid
      INNER JOIN recruit.recruit_solves  AS recruit_solves ON recruit_attempts.id = recruit_solves.aid
      INNER join hr_analytics.global.dim_content_questions  AS dim_content_questions ON recruit_solves.qid = dim_content_questions.question_id
      WHERE ((ever_paid_companies_inc_tcs.company_stripe_plan ) <> 'free' AND (ever_paid_companies_inc_tcs.company_stripe_plan ) <> 'locked' AND (ever_paid_companies_inc_tcs.company_stripe_plan ) <> 'trial' OR (ever_paid_companies_inc_tcs.company_stripe_plan ) IS NULL) AND (dim_recruit_company_data.company_data_key ) = 'enable_projects' AND (dim_recruit_company_data.company_data_value ) = 'true' AND
      (dim_content_questions.question_type ) IN ('fullstack', 'sudorank')
      and recruit_tests.draft=0
      and recruit_tests.state <> 3
      and recruit_attempts.tid > 0
      and lower(recruit_attempts.email) not like '%@hackerrank.com%'
      and lower(recruit_attempts.email) not like '%@hackerrank.net%'
      and lower(recruit_attempts.email) not like '%@interviewstreet.com%'
      and lower(recruit_attempts.email) not like '%sandbox17e2d93e4afe44ea889d89aadf6d413f.mailgun.org%'
      and lower(recruit_attempts.email) not like '%strongqa.com%'
      and recruit_attempts.status =  7
      and recruit_solves.aid > 0
      and recruit_solves.status = 2)
      )
      group by 1,2,3
      having arr > 10000
      order by 4 desc
      ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: role_name {
    type: string
    sql: ${TABLE}.role_name ;;
  }

  dimension: company_id {
    type: number
    sql: ${TABLE}.company_id ;;
  }

  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
  }

  dimension: arr {
    type: number
    sql: ${TABLE}.arr ;;
  }

  set: detail {
    fields: [role_name, company_id, company_name, arr]
  }
}