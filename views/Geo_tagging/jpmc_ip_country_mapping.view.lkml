view: jpmc_ip_country_mapping {
  derived_table: {    sql:select * from analytics_platform_dev.geo_location_test.jpmc_ip_country_mapping
    ;;}

  dimension: country {
    type: string
    map_layer_name: countries
    sql: ${TABLE}.country ;;
  }

  dimension: ip_address {
    type: string
    sql: ${TABLE}.ip_address ;;
  }

 measure: count {
    type: count
  }
  }
