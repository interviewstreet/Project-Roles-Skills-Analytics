view: aws_ses_mail {
  sql_table_name: mails_rs_replica.mail.aws_ses_mail ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }
  dimension: application {
    type: string
    sql: ${TABLE}.application ;;
  }
  dimension: attachments {
    type: string
    sql: ${TABLE}.attachments ;;
  }
  dimension: aws_request_id {
    type: string
    sql: ${TABLE}.aws_request_id ;;
  }
  dimension: aws_response {
    type: string
    sql: ${TABLE}.aws_response ;;
  }
  dimension: bcc {
    type: string
    sql: ${TABLE}.bcc ;;
  }
  dimension: body_html {
    type: string
    sql: ${TABLE}.body_html ;;
  }
  dimension: body_text {
    type: string
    sql: ${TABLE}.body_text ;;
  }
  dimension: bounced {
    type: number
    sql: ${TABLE}.bounced ;;
  }
  dimension: cc {
    type: string
    sql: ${TABLE}.cc ;;
  }
  dimension: complained {
    type: number
    sql: ${TABLE}.complained ;;
  }
  dimension: custom_headers {
    type: string
    sql: ${TABLE}.custom_headers ;;
  }
  dimension: delivered {
    type: number
    sql: ${TABLE}.delivered ;;
  }
  dimension: entity_id {
    type: number
    sql: ${TABLE}.entity_id ;;
  }
  dimension: entity_type {
    type: string
    sql: ${TABLE}.entity_type ;;
  }
  dimension: from {
    type: string
    sql: ${TABLE}."from" ;;
  }
  dimension_group: insert {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.insert_time ;;
  }
  dimension: json_ld {
    type: string
    sql: ${TABLE}.json_ld ;;
  }
  dimension_group: launch {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.launch_time ;;
  }
  dimension: meta {
    type: string
    sql: ${TABLE}.meta ;;
  }
  dimension: opened {
    type: number
    sql: ${TABLE}.opened ;;
  }
  dimension: preview_text {
    type: string
    sql: ${TABLE}.preview_text ;;
  }
  dimension_group: process {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.process_time ;;
  }
  dimension: reply_to {
    type: string
    sql: ${TABLE}.reply_to ;;
  }
  dimension: return_path {
    type: string
    sql: ${TABLE}.return_path ;;
  }
  dimension: status {
    type: number
    sql: ${TABLE}.status ;;
  }
  dimension: subject {
    type: string
    sql: ${TABLE}.subject ;;
  }
  dimension: tag {
    type: string
    sql: ${TABLE}.tag ;;
  }
  dimension: to {
    type: string
    sql: ${TABLE}."to" ;;
  }
  dimension: tracking {
    type: number
    sql: ${TABLE}.tracking ;;
  }
  dimension: tracking_data {
    type: string
    sql: ${TABLE}.tracking_data ;;
  }
  dimension: uuid {
    type: string
    sql: ${TABLE}.uuid ;;
  }
  dimension: vendor {
    type: string
    sql: ${TABLE}.vendor ;;
  }
  dimension: vendor_tracking_id {
    type: string
    sql: ${TABLE}.vendor_tracking_id ;;
  }
  dimension: watch_html {
    type: string
    sql: ${TABLE}.watch_html ;;
  }

  measure: invited_count_distinct {
    type: count_distinct
    sql: CASE
         WHEN ${TABLE}.delivered = 1 THEN ${TABLE}.entity_id
         ELSE NULL
       END ;;
  }

  measure: opened_count_distinct {
    type: count_distinct
    sql: CASE
         WHEN ${TABLE}.opened = 1 THEN ${TABLE}.entity_id
         ELSE NULL
       END ;;
  }
  measure: count {
    type: count
    drill_fields: [id]
  }
}
