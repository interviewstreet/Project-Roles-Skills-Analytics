view: lang_based_on_lib_questions {
    derived_table: {
      sql: select

              language,
              date_trunc('month', attempt_starttime) as month_year,
              count(distinct question_id) as questions,
              count(distinct attempt_id) as attempts,
              count(distinct test_id) as active_tests,
              count(distinct company_id) as active_customers


              from
                  (select
                      company_id,
                      rt.test_id,
                      test_name,
                      json_extract_path_text(question_type_attributes, 'languages', true) as language_list,

                      case /*when ( lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%java%'
                                  and lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%python%'
                                  and ( lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%c%'
                                          or lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%cpp%')
                                  and ( lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%csharp%'
                                          or lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%c#%')
                                ) then 'java-python-cpp-csharp-javascript'

                           when ( lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%java%'
                                  and lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%python%'
                                  and ( lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%c%'
                                          or lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%cpp%')
                                  and ( lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%csharp%'
                                          or lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%c#%')
                                  and lower(json_extract_path_text(question_type_attributes, 'languages', true)) not like '%javascript%'
                                ) then 'java-python-cpp-csharp'

                           when ( lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%java%'
                                  and lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%python%'
                                  and ( lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%c%'
                                          or lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%cpp%')
                                  and lower(json_extract_path_text(question_type_attributes, 'languages', true)) not like '%javascript%'
                                ) then 'java-python-cpp'

                           when ( lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%java%'
                                  and lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%python%'
                                  and lower(json_extract_path_text(question_type_attributes, 'languages', true)) not like '%javascript%'
                                ) then 'java-python'

                           when ( lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%java%'
                                  and ( lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%c%'
                                          or lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%cpp%')
                                  and lower(json_extract_path_text(question_type_attributes, 'languages', true)) not like '%javascript%'
                                ) then 'java-cpp'

                           when ( lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%python%'
                                  and ( lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%c%'
                                          or lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%cpp%')
                                  and lower(json_extract_path_text(question_type_attributes, 'languages', true)) not like '%javascript%'
                                ) then 'python-cpp'

                           when ( lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%java%'
                                  and ( lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%c%'
                                          or lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%cpp%')
                                  and lower(json_extract_path_text(question_type_attributes, 'languages', true)) not like '%javascript%'
                                ) then 'java-cpp'*/

                          when  lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%java%'
                          and lower(json_extract_path_text(question_type_attributes, 'languages', true)) not like '%javascript%' then 'java'

                          when  lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%python%' then 'python'

                          when     lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%c%'

                          and lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%cpp%' then 'c/cpp'

                           when lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%javascript%' then 'javascript'
                           when ( lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%csharp%'
                                  or lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%c#%') then 'csharp'
                           when lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%sql%' then 'sql'

                           when lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%php%' then 'php'
                           when lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%swift%' then 'swift'
                           when lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%go%' then 'go'
                           when lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%ruby%' then 'ruby'
                           when lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%pypy3%' then 'pypy3'
                           when lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%kotlin%' then 'kotlin'
                           when lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%r%' then 'r'
                           when lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%scala%' then 'scala'
                           when lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%pypy%' then 'pypy'
                           when lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%bash%' then 'bash'
                           when lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%objectivec%' then 'objectivec'
                           when lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%perl%' then 'perl'
                           when lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%clojure%' then 'clojure'
                           when lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%typescript%' then 'typescript'
                           when lower(json_extract_path_text(question_type_attributes, 'languages', true)) like '%haskell%' then 'haskell'

                           else 'others' end as language,

                      cq.question_id,
                      cq.question_type,
                      ra.attempt_id,
                      JSON_ARRAY_LENGTH(json_extract_path_text(question_type_attributes, 'languages', true)) as no_of_languages,
                      attempt_starttime,
                      attempt_endtime

                      -- count(distinct ra.attempt_id) as total_attempt_count,
                      -- count(distinct cq.question_id) as total_questions
                      -- count(distinct case when cq.question_type in ('code', 'approx') then cq.question_id end) as coding_question_count,
                      -- count(distinct case when JSON_ARRAY_LENGTH(json_extract_path_text(question_type_attributes, 'languages', true)) >= 10 then cq.question_id end) as questions_with_multiple_languages,



                      -- count(distinct case when JSON_ARRAY_LENGTH(json_extract_path_text(question_type_attributes, 'languages', true)) < 10  then cq.question_id end) as questions_not_with_multiple_languages,
                      -- count(distinct case when JSON_ARRAY_LENGTH(json_extract_path_text(question_type_attributes, 'languages', true)) >= 10 then cq.question_id end) +
                      -- count(distinct case when JSON_ARRAY_LENGTH(json_extract_path_text(question_type_attributes, 'languages', true)) < 10  then cq.question_id end) addition ,

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

                              and rc.company_id not in ( 65904, 107170, 76987, 37380, 93614) --- exclude tcs  lnd accounts
                              and rc.company_id not in (106529,46242) --- exclude internal test setters
                              ) as ever_paid_accounts

                        ON rt.test_company_id = ever_paid_accounts.company_id
                        and rt.test_state = 1   -- Considered only Live Tests (Confirm if archived adn demo are also to be included)
                        and rt.test_draft = 0   -- Considered only published Tests
                        -- and date(rt.test_created_at) >= date(dateadd(d,-180,current_date)) -- # Date Filter for Tests

                  inner join hr_analytics.global.fact_recruit_attempt ra
                        on rt.test_id = ra.attempt_test_id
                        and ra.attempt_id > 0
                        and date(attempt_starttime) >= '2019-01-01'
                      --   and date(attempt_starttime) <= '2022-06-30'

                  -- inner join hr_analytics.global.fact_recruit_solve rs
                  --       on ra.attempt_test_id = rs.solve_test_id
                  --       and solve_attempt_id > 0
                  --       and solve_status = 2
                  inner join hr_analytics.global.dim_recruit_test_question rtq
                        on rt.test_id = rtq.test_question_test_id
                        and rtq.test_question_active = 1
                  inner join hr_analytics.global.dim_content_questions cq
                        on rtq.test_question_question_id = cq.question_id
                        -- on rs.solve_question_id = cq.question_id
                        and cq.question_product = 1
                        and cq.question_type in ('code', 'approx','database')
                  ) raw_dt

              where no_of_languages <= 5
              group by 1,2;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: language {
      type: string
      sql: ${TABLE}.language ;;
    }

    dimension_group: month_year {
      type: time
      sql: ${TABLE}.month_year ;;
    }

    dimension: questions {
      type: number
      sql: ${TABLE}.questions ;;
    }

    dimension: attempts {
      type: number
      sql: ${TABLE}.attempts ;;
    }

    dimension: active_tests {
      type: number
      sql: ${TABLE}.active_tests ;;
    }

    dimension: active_customers {
      type: number
      sql: ${TABLE}.active_customers ;;
    }

    set: detail {
      fields: [
        language,
        month_year_time,
        questions,
        attempts,
        active_tests,
        active_customers
      ]
    }
  }
