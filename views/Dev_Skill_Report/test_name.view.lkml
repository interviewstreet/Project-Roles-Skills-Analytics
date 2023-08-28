
view: test_name {
  derived_table: {
    sql: -- ######## Tests with Specific Skills Mentioned in Names ########
      select
      ra.starttime as starttime,
      rt.company_id as company_id,

      case when lower(rt.name) like '%python%'
                and lower(rt.name) like '%java%'
                and (lower(rt.name) like '%cpp%' or lower(rt.name) like '%c++%')
                and lower(rt.name) not like '%javascript%'
                  then 'python-java-cpp'

          when lower(rt.name) like '%python%'
                and lower(rt.name) like '%sql%'
                and lower(rt.name) not like '%javascript%'
                  then 'python-sql'

          when lower(rt.name) like '%python%'
                and lower(rt.name) like '%java%'
                and lower(rt.name) not like '%javascript%'
                  then 'python-java'

          when lower(rt.name) like '%java%'
                and (lower(rt.name) like '%cpp%' or lower(rt.name) like '%c++%')
                and lower(rt.name) not like '%javascript%'
                  then 'cpp-java'

          when (lower(rt.name) like '%machine learning%'
                   or lower(rt.name) like '%data scientist%'
                   or lower(rt.name) like '%data science%'
                   or lower(rt.name) like '%deep learning%'
                   or lower(rt.name) like '%mle%'
                   or lower(rt.name) like '%ai%'
                   or lower(rt.name) like '%artificial%'
                   or lower(rt.name) like '%prompt engineer%'
                   or lower(rt.name) like '%llm%')
                  then 'machine-learning-ai-deep-learning'

          when (lower(rt.name) like '%linux%'
                   or lower(rt.name) like '%bash%')
                  then 'linux-bash'

          when lower(rt.name) like '%python%' then 'python'
           when lower(rt.name) like '%sql%' then 'sql'
           when (lower(rt.name) like '%cpp%' or lower(rt.name) like '%c++%') then 'cpp'
           when (lower(rt.name) like '%c%sharp%' or lower(rt.name) like '%c#%') then 'csharp'
           when lower(rt.name) like '%java%' then 'java'
           when lower(rt.name) like '%javascript%' then 'javascript'


           else 'others' end as language,

      count(distinct ra.id) as total_attempt_count,
      count(distinct rt.id) as active_tests,
      count(distinct ever_paid_accounts.company_id) as active_customers

      from recruit_rs_replica.recruit.recruit_tests rt
      INNER JOIN
              (with ever_paid as
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

              --and rc.company_id not in (65904,107170) --- exclude tcs  lnd accounts
              --and rc.company_id not in (106529,46242) --- exclude internal test setters
              ) as ever_paid_accounts

      ON rt.company_id = ever_paid_accounts.company_id
          and rt.state = 1   -- Considered only Live Tests (Confirm if archived adn demo are also to be included)
          and rt.draft = 0   -- Considered only published Tests
          and (lower(rt.name) like '%python%'
               or lower(rt.name) like '%sql%'
               or lower(rt.name) like '%c++%'
               or lower(rt.name) like '%cpp%'
               or lower(rt.name) like '%c%sharp%'
               or lower(rt.name) like '%c#%'
               or lower(rt.name) like '%java%'
               or lower(rt.name) like '%javascript%'
               or lower(rt.name) like '%machine learning%'
               or lower(rt.name) like '%data scientist%'
               or lower(rt.name) like '%data science%'
               or lower(rt.name) like '%deep learning%'
               or lower(rt.name) like '%mle%'
               or lower(rt.name) like '%ai%'
               or lower(rt.name) like '%artificial%'
               or lower(rt.name) like '%linux%'
               or lower(rt.name) like '%bash%'
                   or lower(rt.name) like '%prompt engineer%'
                   or lower(rt.name) like '%llm%'
               )
      inner join recruit_rs_replica.recruit.recruit_attempts ra
          on rt.id = ra.tid
      group by 1,2,3 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension_group: starttime {
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
    sql: ${TABLE}.starttime ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: total_attempt_count {
    type: number
    sql: ${TABLE}.total_attempt_count ;;
  }

  dimension: active_tests {
    type: number
    sql: ${TABLE}.active_tests ;;
  }

  dimension: company_id {
    type: number
    sql: ${TABLE}.company_id ;;
  }

  dimension: active_customers {
    type: number
    sql: ${TABLE}.active_customers ;;
  }

  set: detail {
    fields: [
      starttime_year,
      language,
      company_id,
      total_attempt_count,
      active_tests,
      active_customers
    ]
  }
}
