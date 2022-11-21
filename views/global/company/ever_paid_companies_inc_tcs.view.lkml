view: ever_paid_companies_inc_tcs {

  derived_table: {
    sql:
    ---- Ever Paid Customers | TCS LND/ Internal accounts Excluded
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
      ;;
  }


  dimension: company_codepair {
    type: number
    sql: ${TABLE}.company_codepair ;;
  }

  dimension_group: company_contract {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.company_contract_date ;;
  }

  dimension_group: company_contract_start {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.company_contract_start_date ;;
  }

  dimension: company_country {
    type: string
    sql: ${TABLE}.company_country ;;
  }

  dimension_group: company_created {
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
    sql: ${TABLE}.company_created_at ;;
  }

  dimension: company_email_domain {
    type: string
    sql: ${TABLE}.company_email_domain ;;
  }

  dimension: company_email_from {
    type: string
    sql: ${TABLE}.company_email_from ;;
  }

  dimension: company_hr_company_id {
    type: number
    sql: ${TABLE}.company_hr_company_id ;;
    drill_fields: [company_id]
  }

  dimension: company_id {
    type: number
    sql: ${TABLE}.company_id ;;
  }

  dimension: company_industry_segment {
    type: string
    sql: ${TABLE}.company_industry_segment ;;
  }

  dimension: company_invites {
    type: number
    sql: ${TABLE}.company_invites ;;
  }

  dimension: company_libraries {
    type: string
    sql: ${TABLE}.company_libraries ;;
  }

  dimension: company_logo {
    type: string
    sql: ${TABLE}.company_logo ;;
  }

  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
  }

  dimension: company_organization_size {
    type: string
    sql: ${TABLE}.company_organization_size ;;
  }

  dimension: company_owner {
    type: number
    sql: ${TABLE}.company_owner ;;
  }

  dimension: company_owners_team_id {
    type: number
    sql: ${TABLE}.company_owners_team_id ;;
  }

  dimension: company_paid_accounts {
    type: number
    sql: ${TABLE}.company_paid_accounts ;;
  }

  dimension: company_paid_codepair_pro_accounts {
    type: number
    sql: ${TABLE}.company_paid_codepair_pro_accounts ;;
  }

  dimension: company_paid_codescreen_accounts {
    type: number
    sql: ${TABLE}.company_paid_codescreen_accounts ;;
  }

  dimension: company_paid_codescreen_review_accounts {
    type: number
    sql: ${TABLE}.company_paid_codescreen_review_accounts ;;
  }

  dimension: company_paid_developer_accounts {
    type: number
    sql: ${TABLE}.company_paid_developer_accounts ;;
  }

  dimension: company_paid_interviewer_accounts {
    type: number
    sql: ${TABLE}.company_paid_interviewer_accounts ;;
  }

  dimension_group: company_payment {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.company_payment_date ;;
  }

  dimension: company_payment_day {
    type: number
    sql: ${TABLE}.company_payment_day ;;
  }

  dimension: company_payment_method {
    type: string
    sql: ${TABLE}.company_payment_method ;;
  }

  dimension: company_plagiarism {
    type: number
    sql: ${TABLE}.company_plagiarism ;;
  }

  dimension: company_pricing_model {
    type: string
    sql: ${TABLE}.company_pricing_model ;;
  }

  dimension_group: company_refill {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.company_refill_date ;;
  }

  dimension: company_slug {
    type: string
    sql: ${TABLE}.company_slug ;;
  }

  dimension: company_stripe_plan {
    type: string
    sql: ${TABLE}.company_stripe_plan ;;
  }

  dimension: company_stripe_subscription {
    type: string
    sql: ${TABLE}.company_stripe_subscription ;;
  }

  dimension: company_subscription_invites {
    type: number
    sql: ${TABLE}.company_subscription_invites ;;
  }

  dimension: company_tasks {
    type: number
    sql: ${TABLE}.company_tasks ;;
  }

  dimension: company_type {
    type: string
    sql: ${TABLE}.company_type ;;
  }

  dimension: company_unique_id {
    type: string
    sql: ${TABLE}.company_unique_id ;;
  }

  dimension_group: company_updated {
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
    sql: ${TABLE}.company_updated_at ;;
  }

  dimension: companyid {
    type: number
    value_format_name: id
    sql: ${TABLE}.companyid ;;
  }

  measure: count {
    type: count
    drill_fields: [company_name, company_id]
  }

  measure: distinct_company_count {
    type: count_distinct
    sql: ${company_id} ;;
    drill_fields: [company_name,company_id]
  }
}
