view: lang_based_on_limit_set_by_customer {
    derived_table: {
      sql:
                                with ever_paid_accounts as    (with ever_paid as
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

                              and rc.company_id not in ( 65904, 107170, 76987, 37380, 93614) --- exclude tcs  lnd accounts
                              and rc.company_id not in (106529,46242) --- exclude internal test setters
                              ),




       test_lang_mapp as
              (
              SELECT
                  rtd.tid, rt.created_at as test_created_at, rtd.value,LEN(rtd.value) - LEN(REPLACE(rtd.value, ',', '')) +1 as lang,seq.n,
                  SPLIT_PART(rtd.value, ',', seq.n) AS programming_language
              FROM
              recruit.recruit_tests_data rtd
              inner join
              (select row_number() over(order by true)::integer as n from recruit.recruit_tests_data limit 20) seq
              on seq.n <= LEN(rtd.value) - LEN(REPLACE(rtd.value, ',', ''))+1
              --and
              --rtd.created_at >= '2021-01-01'
              inner join
              recruit.recruit_tests rt
              on rt.id = rtd.tid
              and
              rt.created_at >= '2019-01-01'
              inner join ever_paid_accounts
              on
              rt.company_id = ever_paid_accounts.company_id
              WHERE
              key = 'allowedLanguages'


              and lang <=5 --and lang >1
             -- and rtd.tid = 1759967
              )
              select case when programming_language like '%cpp%' then 'cpp'
               when programming_language like '%py%'then 'python'
                when programming_language like '%java%' and programming_language not like '%javascript%' then 'java'
                else programming_language end as lang,
              test_created_at,
              count(distinct tid)
              from test_lang_mapp
              where programming_language not in ('nil',' "cpp"',' "cpp14"',' "java"',' "java"]',' "java8"]',' "python3"]','11','India','["c"','["java8"','["python"','abc','')
              group by 1,2
              order by 2 desc ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: lang {
      type: string
      sql: ${TABLE}.lang ;;
    }

    dimension_group: test_created_at {
      type: time
      sql: ${TABLE}.test_created_at ;;
    }

    dimension: count_ {
      type: number
      sql: ${TABLE}.count ;;
    }

    set: detail {
      fields: [
        lang,
        test_created_at_time,
        count_
      ]
    }
  }
