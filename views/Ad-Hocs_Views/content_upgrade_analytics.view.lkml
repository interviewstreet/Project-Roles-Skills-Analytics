view: content_upgrade_analytics {

    derived_table: {
      sql: select
json_extract_path_text(cq.custom,'company',TRUE) as company_id,
rc.name as company_name,
cq.id as question_id,
cq.name as question_name,
count(distinct rs.id) as question_attempts,
json_extract_path_text(cq.custom,'upgraded_on',TRUE) AS Upgraded_on,
cq.type as question_type,
json_extract_path_text(cq.stack,'name',TRUE) AS stack,
json_extract_path_text(cq.type_attributes,'sub_type',TRUE) AS stack_type, -- this value will be set only when a question is upgraded
cq.created_at, cq.updated_at

from content.questions cq
INNER JOIN recruit_rs_replica.recruit.recruit_companies rc ON rc.id = json_extract_path_text(cq.custom,'company',TRUE)
left join recruit_rs_replica.recruit.recruit_solves rs on rs.qid = cq.id

WHERE
cq.type IN ('fullstack','sudorank')
and stack_type IN ('angularjs', 'angularjs_vm', 'angularjs14', 'angularjs14_vm',
                        'reactjs', 'reactjs_vm', 'reactjs14', 'reactjs14_vm',
                        'nodejs', 'nodejs_vm', 'nodejs14', 'nodejs14_vm',
                        'java_spring_boot', 'java_spring_boot_vm', 'java17_maven', 'java17_maven_vm',
                        'java17_gradle', 'java17_gradle_vm', 'dot_net', 'dot_net_vm', 'dotnet3',
                        'pyspark', 'pyspark_vm', 'rails', 'rails_vm',
                        'python_django', 'python_django_vm', 'python3_django', 'python3_django_vm',
                        'cpp', 'cpp_vm', 'php', 'php_vm', 'php_codeigniter', 'php_codeigniter_vm',
                        'php_laravel', 'php_laravel_vm', 'php_symfony', 'php_symfony_vm',
                        'android_java', 'android_java_vm', 'android_kotlin', 'android_kotlin_vm',
                        'react_native', 'jupyter')
AND cq.author != '{"id": 41872, "type": "user"}'
and lower(rc.name) NOT LIKE '%problem setters%'
and lower(rc.name) NOT LIKE '%hackerrank%'

and rc.type not in ('locked' , 'free', 'trial')
group by 1,2,3,4,6,7,8,9,10,11
order by Upgraded_on   ;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: company_id {
      type: number
      sql: ${TABLE}.company_id ;;
    }

    dimension: company_name {
      type: string
      sql: ${TABLE}.company_name ;;
    }

    dimension: question_id {
      type: number
      sql: ${TABLE}.question_id ;;
    }

    dimension: question_name {
      type: string
      sql: ${TABLE}.question_name ;;
    }

  dimension: question_attempts {
    type: number
    sql: ${TABLE}.question_attempts ;;
  }


    dimension: upgraded_on {
      type: string
      sql: ${TABLE}.upgraded_on ;;
    }

    dimension: question_type {
      type: string
      sql: ${TABLE}.question_type ;;
    }

    dimension: stack {
      type: string
      sql: ${TABLE}.stack ;;
    }

    dimension: stack_type {
      type: string
      sql: ${TABLE}.stack_type ;;
    }

    dimension_group: question_created_at {
      type: time
      sql: ${TABLE}.created_at ;;
    }

    dimension_group: question_updated_at {
      type: time
      sql: ${TABLE}.updated_at ;;
    }

    set: detail {
      fields: [
        company_id,
        company_name,
        question_id,
        question_name,
        question_attempts,
        upgraded_on,
        question_type,
        stack,
        stack_type,
        question_created_at_time,
        question_updated_at_time
      ]
    }

}
