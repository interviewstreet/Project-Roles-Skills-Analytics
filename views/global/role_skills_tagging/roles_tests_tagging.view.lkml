view: roles_tests_tagging {
  derived_table: {
    sql: select frr.role_name ,frr.role_company_id, atm.additional_tag_mapping_entity_id as test_id
            from
            global.fact_rs_roles frr
            inner join global.fact_recruit_additional_tag at on frr.role_unique_id = at.additional_tag_tag
            and at.additional_tag_tag_type = 4
            and at.additional_tag_taggable_type = 'Recruit::Test'
            and frr.role_standard = 1
            inner join global.fact_recruit_additional_tag_mapping atm on atm.additional_tag_mapping_tag_id = at.additional_tag_id
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
