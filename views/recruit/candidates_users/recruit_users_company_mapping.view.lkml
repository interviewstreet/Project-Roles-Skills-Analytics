view: recruit_users_company_mapping {
  sql_table_name: recruit.recruit_users ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: admin {
    type: number
    sql: ${TABLE}.admin ;;
  }

  dimension: analytics {
    type: number
    sql: ${TABLE}.analytics ;;
  }

  dimension: authentication_token {
    type: string
    sql: ${TABLE}.authentication_token ;;
  }

  dimension: candidates_permission {
    type: string
    sql: ${TABLE}.candidates_permission ;;
  }

  dimension: codepair {
    type: number
    sql: ${TABLE}.codepair ;;
  }

  dimension: codepair_role {
    type: string
    sql: ${TABLE}.codepair_role ;;
  }

  dimension: codescreen_role {
    type: string
    sql: ${TABLE}.codescreen_role ;;
  }

  dimension: company {
    type: string
    sql: ${TABLE}.company ;;
  }

  dimension: company_admin {
    type: number
    sql: ${TABLE}.company_admin ;;
  }

  dimension: company_id {
    type: number
    sql: ${TABLE}.company_id ;;
  }

  dimension_group: confirmation_sent {
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
    sql: ${TABLE}.confirmation_sent_at ;;
  }

  dimension: confirmation_token {
    type: string
    sql: ${TABLE}.confirmation_token ;;
  }

  dimension_group: confirmed {
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
    sql: ${TABLE}.confirmed_at ;;
  }

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension_group: created_at {
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
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: current_sign_in {
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
    sql: ${TABLE}.current_sign_in_at ;;
  }

  dimension: current_sign_in_ip {
    type: string
    sql: ${TABLE}.current_sign_in_ip ;;
  }

  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
  }

  dimension: email_activated {
    type: number
    sql: ${TABLE}.email_activated ;;
  }

  dimension: email_from {
    type: string
    sql: ${TABLE}.email_from ;;
  }

  dimension: embed {
    type: number
    sql: ${TABLE}.embed ;;
  }

  dimension: encrypted_password {
    type: string
    sql: ${TABLE}.encrypted_password ;;
  }

  dimension: failed_attempts {
    type: number
    sql: ${TABLE}.failed_attempts ;;
  }

  dimension: firstname {
    type: string
    sql: ${TABLE}.firstname ;;
  }

  dimension: interviews_permission {
    type: string
    sql: ${TABLE}.interviews_permission ;;
  }

  dimension_group: invitation_accepted {
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
    sql: ${TABLE}.invitation_accepted_at ;;
  }

  dimension_group: invitation_created {
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
    sql: ${TABLE}.invitation_created_at ;;
  }

  dimension: invitation_limit {
    type: number
    sql: ${TABLE}.invitation_limit ;;
  }

  dimension_group: invitation_sent {
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
    sql: ${TABLE}.invitation_sent_at ;;
  }

  dimension: invitation_token {
    type: string
    sql: ${TABLE}.invitation_token ;;
  }

  dimension: invited_by_id {
    type: number
    sql: ${TABLE}.invited_by_id ;;
  }

  dimension: invited_by_type {
    type: string
    sql: ${TABLE}.invited_by_type ;;
  }

  dimension: invites {
    type: number
    sql: ${TABLE}.invites ;;
  }

  dimension_group: last_seen {
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
    sql: ${TABLE}.last_seen_at ;;
  }

  dimension_group: last_sign_in {
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
    sql: ${TABLE}.last_sign_in_at ;;
  }

  dimension: last_sign_in_ip {
    type: string
    sql: ${TABLE}.last_sign_in_ip ;;
  }

  dimension: lastname {
    type: string
    sql: ${TABLE}.lastname ;;
  }

  dimension: libraries {
    type: string
    sql: ${TABLE}.libraries ;;
  }

  dimension_group: locked {
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
    sql: ${TABLE}.locked_at ;;
  }

  dimension: logo {
    type: string
    sql: ${TABLE}.logo ;;
  }

  dimension: mixpanel_token {
    type: string
    sql: ${TABLE}.mixpanel_token ;;
  }

  dimension: paid_child_accounts {
    type: number
    sql: ${TABLE}.paid_child_accounts ;;
  }

  dimension: parent {
    type: number
    sql: ${TABLE}.parent ;;
  }

  dimension: password {
    type: string
    sql: ${TABLE}.password ;;
  }

  dimension_group: payment {
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
    sql: ${TABLE}.payment_date ;;
  }

  dimension: payment_day {
    type: number
    sql: ${TABLE}.payment_day ;;
  }

  dimension: phone {
    type: string
    sql: ${TABLE}.phone ;;
  }

  dimension: plagiarism {
    type: number
    sql: ${TABLE}.plagiarism ;;
  }

  dimension: pricing_model {
    type: string
    sql: ${TABLE}.pricing_model ;;
  }

  dimension: questions_permission {
    type: string
    sql: ${TABLE}.questions_permission ;;
  }

  dimension_group: remember_created {
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
    sql: ${TABLE}.remember_created_at ;;
  }

  dimension_group: reset_password_sent {
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
    sql: ${TABLE}.reset_password_sent_at ;;
  }

  dimension: reset_password_token {
    type: string
    sql: ${TABLE}.reset_password_token ;;
  }

  dimension: role {
    type: string
    sql: ${TABLE}.role ;;
  }

  dimension: shared_candidates_permission {
    type: string
    sql: ${TABLE}.shared_candidates_permission ;;
  }

  dimension: shared_interviews_permission {
    type: string
    sql: ${TABLE}.shared_interviews_permission ;;
  }

  dimension: shared_questions_permission {
    type: string
    sql: ${TABLE}.shared_questions_permission ;;
  }

  dimension: shared_tests_permission {
    type: string
    sql: ${TABLE}.shared_tests_permission ;;
  }

  dimension: sign_in_count {
    type: number
    sql: ${TABLE}.sign_in_count ;;
  }

  dimension: status {
    type: number
    sql: ${TABLE}.status ;;
  }

  dimension: stripe_credit_card_number {
    type: string
    sql: ${TABLE}.stripe_credit_card_number ;;
  }

  dimension: stripe_customer_id {
    type: string
    sql: ${TABLE}.stripe_customer_id ;;
  }

  dimension: stripe_plan {
    type: string
    sql: ${TABLE}.stripe_plan ;;
  }

  dimension: stripe_subscription {
    type: string
    sql: ${TABLE}.stripe_subscription ;;
  }

  dimension: subscription_invites {
    type: number
    sql: ${TABLE}.subscription_invites ;;
  }

  dimension: team_admin {
    type: number
    sql: ${TABLE}.team_admin ;;
  }

  dimension: tests_permission {
    type: string
    sql: ${TABLE}.tests_permission ;;
  }

  dimension: theme {
    type: string
    sql: ${TABLE}.theme ;;
  }

  dimension_group: timestamp {
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
    sql: ${TABLE}.timestamp ;;
  }

  dimension: timezone {
    type: string
    sql: ${TABLE}.timezone ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: unconfirmed_email {
    type: string
    sql: ${TABLE}.unconfirmed_email ;;
  }

  dimension: unlock_token {
    type: string
    sql: ${TABLE}.unlock_token ;;
  }

  dimension_group: updated {
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
    sql: ${TABLE}.updated_at ;;
  }

  measure: count {
    type: count
    drill_fields: [id, lastname, firstname]
  }
}
