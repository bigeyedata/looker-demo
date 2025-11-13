view: customer {
  sql_table_name: `bigeye-se-demo.tooy_demo_db.customer` ;;
  label: "Customers"

  # Primary Key
  dimension: customer_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.customer_id ;;
    label: "Customer ID"
  }

  # Customer Name Fields
  dimension: first_name {
    type: string
    sql: ${TABLE}.first_name ;;
    label: "First Name"
  }

  dimension: last_name {
    type: string
    sql: ${TABLE}.last_name ;;
    label: "Last Name"
  }

  dimension: customer_name {
    type: string
    sql: CONCAT(${first_name}, ' ', ${last_name}) ;;
    label: "Customer Name"
  }

  # Contact Information
  dimension: email {
    type: string
    sql: ${TABLE}.email ;;
    label: "Email"
  }

  # Company Information
  dimension: company_name {
    type: string
    sql: ${TABLE}.company_name ;;
    label: "Company Name"
  }

  # Company Address
  dimension: company_address_line_1 {
    type: string
    sql: ${TABLE}.company_address_line_1 ;;
    label: "Company Address Line 1"
  }

  dimension: company_address_line_2 {
    type: string
    sql: ${TABLE}.company_address_line_2 ;;
    label: "Company Address Line 2"
  }

  dimension: company_city {
    type: string
    sql: ${TABLE}.company_city ;;
    label: "Company City"
  }

  dimension: company_state {
    type: string
    sql: ${TABLE}.company_state ;;
    label: "Company State"
  }

  dimension: company_zip {
    type: string
    sql: ${TABLE}.company_zip ;;
    label: "Company ZIP"
  }

  dimension: full_company_address {
    type: string
    sql: CONCAT(${company_address_line_1}, ', ', ${company_city}, ', ', ${company_state}, ' ', ${company_zip}) ;;
    label: "Full Company Address"
  }

  # Timestamps
  dimension_group: created {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.created_timestamp ;;
    label: "Created Date"
  }

  dimension_group: updated {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.update_timestamp ;;
    label: "Updated Date"
  }

  # Measures
  measure: count {
    type: count
    label: "Number of Customers"
    drill_fields: [customer_id, customer_name, email, company_name]
  }

  measure: count_with_orders {
    type: count_distinct
    sql: ${customer_id} ;;
    label: "Customers with Orders"
    filters: [orders.order_id: "NOT NULL"]
  }
}
