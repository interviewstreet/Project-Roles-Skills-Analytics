view: lang_based_on_test_names {

    derived_table: {
      sql: -- ######## Tests with Specific Skills Mentioned in Names ########


              select
              -- test_id,
              -- test_name,
              date_trunc('month', attempt_starttime) as month_year,

                case when lower(test_name) like '%python%' then 'python'
                when lower(test_name) like '%sql%' then 'sql'
                when (lower(test_name) like '%cpp%' or lower(test_name) like '%c++%') then 'cpp'
                when (lower(test_name) like '%c%sharp%' or lower(test_name) like '%c#%') then 'csharp'
                when (lower(test_name) like '%java%' and lower(test_name) not like '%java%script%'and lower(test_name) not like '%javascript%')then 'java'
                when (lower(test_name) like '%java%script%' or lower(test_name) like '%javascript%')then 'javascript'
                when lower(test_name) like '%php%'  then 'php'
                when (lower(test_name) like 'go %'or lower(test_name) like '% go %')then 'go'
                when lower(test_name) like '%swift%' then 'swift'
                when lower(test_name) like '%kotlin%' then 'kotlin'
                when lower(test_name) like '%ruby%' then 'ruby'
                when lower(test_name) like '%typescript%' then 'typescript'
                when lower(test_name) like '%scala%' then 'scala'
                when (lower(test_name) like 'r %' or lower(test_name) like '% r %')then 'r'
                when (lower(test_name) like '%html%' or lower(test_name) like '%css%')then 'html/css'
      else 'others'
      end as language,
test_id as tests
              --count(distinct attempt_id) as total_attempt_count,
              --count(distinct test_id) as active_tests,
              --count(distinct company_id) as active_customers

              from hr_analytics.global.dim_recruit_test rt
              INNER JOIN
                      (with ever_paid as
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

                      and rc.company_id not in (65904,107170,76987,37380,93614) --- exclude tcs  lnd accounts
                      and rc.company_id not in (106529,46242) --- exclude internal test setters
                      ) as ever_paid_accounts

              ON rt.test_company_id = ever_paid_accounts.company_id
                  and rt.test_state = 1   -- Considered only Live Tests (Confirm if archived adn demo are also to be included)
                  and rt.test_draft = 0   -- Considered only published Tests
                  and
(lower(test_name) like '%python%'
or lower(test_name) like '%sql%'
or lower(test_name) like '%c++%'
or lower(test_name) like '%cpp%'
or lower(test_name) like '%c%sharp%'
or lower(test_name) like '%c#%'
or lower(test_name) like '%java%'
or lower(test_name) like '%javascript%'
or lower(test_name) like '%typescript%'
or lower(test_name) like '%scala%'
or lower(test_name) like '% go%'
or lower(test_name) like '%go %'
or lower(test_name) like '% go %'
or lower(test_name) like '%php%'
or lower(test_name) like '% php %'
or lower(test_name) like 'php %'
or lower(test_name) like '%swift%'
or lower(test_name) like '%kotlin%'
or lower(test_name) like '%ruby%'
or lower(test_name) like '%typescript%'
or lower(test_name) like '%scala%'
or lower(test_name) like 'r %'
or lower(test_name) like '% r %'
or lower(test_name) like '%html%'
or lower(test_name) like '%css%'
or lower(test_name) like '%javascript%'

 )
              inner join hr_analytics.global.fact_recruit_attempt ra
                  on rt.test_id = ra.attempt_test_id
                  and date(attempt_starttime) >= '2019-01-01'
                  -- and date(attempt_starttime) <= '2022-06-30'
              --group by 1,2
              ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

  measure: tests {
    type: count_distinct
    sql: ${TABLE}.tests ;;
  }

    dimension_group: month_year {
      type: time
      sql: ${TABLE}.month_year ;;
    }

    dimension: language {
      type: string
      sql: ${TABLE}.language ;;
    }

    # dimension: total_attempt_count {
    #   type: number
    #   sql: ${TABLE}.total_attempt_count ;;
    # }

    # dimension: active_tests {
    #   type: number
    #   sql: ${TABLE}.active_tests ;;
    # }

    # dimension: active_customers {
    #   type: number
    #   sql: ${TABLE}.active_customers ;;
    # }

    set: detail {
      fields: [
        month_year_time,
        language,
tests
      ]
    }
  }
