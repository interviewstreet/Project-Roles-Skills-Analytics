view: roles_tests_tagging {
  derived_table: {
    sql: select frr.role_name ,frr.role_company_id, atm.eid as test_id
            from
            global.fact_rs_roles frr
            inner join recruit.recruit_additional_tags at on frr.role_unique_id = at."tag"
            and at.tag_type = 4
            and at.taggable_type = 'Recruit::Test'
            and frr.role_standard = 1
            inner join recruit.recruit_additional_tag_mappings atm on atm.tag_id = at.id
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

  dimension: role_company_id {
    type: number
    sql: ${TABLE}.role_company_id ;;
  }

  dimension: test_id {
    type: number
    sql: ${TABLE}.test_id ;;
  }

  set: detail {
    fields: [role_name, role_company_id, test_id]
  }
}
