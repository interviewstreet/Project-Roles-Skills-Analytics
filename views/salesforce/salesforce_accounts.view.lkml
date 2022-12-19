view: salesforce_accounts {
    derived_table: {
      sql: select hrid_c, max(region_c) as region_c, max(number_of_employees) as number_of_employees,max(arr_c::decimal) as arr
              from hr_analytics.salesforce.accounts
              group by 1;;
    }

    measure: count {
      type: count
      drill_fields: [detail*]
    }

    dimension: hrid_c {
      type: string
      sql: ${TABLE}.hrid_c ;;
    }

    dimension: region_c {
      type: string
      sql: ${TABLE}.region_c ;;
    }

    dimension: number_of_employees {
      type: number
      sql: ${TABLE}.number_of_employees ;;
    }

  dimension: arr {
    type: number
    sql: ${TABLE}.arr ;;
  }

    set: detail {
      fields: [hrid_c, region_c, number_of_employees,arr]
    }
  }
