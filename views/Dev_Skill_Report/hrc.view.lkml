view: hrc{
  derived_table: {
    sql: -- ### Run in Redshift Prod

            select
            extract(year from event_time)as year,
            case when attribute6 in ('cpp','cpp14','cpp20') then 'cpp'
            when attribute6 in ('java','java15','java8') then 'java'
            when attribute6 in ('pypy','python3','pypy3','python') then 'python'
            else attribute6 end as language,
            -- e.hacker_id as hacker_id, hacker_email, attribute6 as language, event_time,
            count(distinct e.hacker_id) as distinct_hackers,
            count(1) as submissions
            -- ROW_NUMBER() OVER (PARTITION BY h.hacker_id
            --                                          ORDER BY h.TIMESTAMP DESC) as series
                    from hr_analytics.global.dim_community_hackers e
                    inner join hr_analytics.public.hr_analytics_events h
                        on e.hacker_id = h.hacker_id
                        and h.event_value in ('CompileTest', 'SubmitCode')
                        and e.hacker_email not like '%@hackerrank.com%'
                        and event_time >= '2021-01-01'
                        -- and e.hacker_id = 9459503
                        --where
            group by 1,2;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }


  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  dimension: language {
    type: string
    sql: ${TABLE}.language ;;
  }

  dimension: distinct_hackers {
    type: number
    sql: ${TABLE}.distinct_hackers ;;
  }

  dimension: submissions {
    type: number
    sql: ${TABLE}.submissions ;;
  }

  set: detail {
    fields: [
      year,
      language,
      distinct_hackers,
      submissions]
  }
}
