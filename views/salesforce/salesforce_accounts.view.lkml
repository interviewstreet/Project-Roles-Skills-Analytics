view: salesforce_accounts {
    derived_table: {
      sql: select hrid_c, region_c, number_of_employees
              from hr_analytics.salesforce.accounts;;
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

    set: detail {
      fields: [hrid_c, region_c, number_of_employees]
    }
  }
