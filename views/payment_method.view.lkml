view: payment_method {
  sql_table_name: `bigeye-se-demo.tooy_demo_db.payment_method` ;;
  label: "Payment Methods"

  # Primary Key
  dimension: payment_method_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.payment_method_id ;;
    label: "Payment Method ID"
  }

  # Foreign Keys
  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    label: "Customer ID"
    hidden: yes
  }

  # Payment Type
  dimension: payment_type {
    type: string
    sql: ${TABLE}.payment_type ;;
    label: "Payment Type"
  }

  # Status
  dimension: active {
    type: yesno
    sql: ${TABLE}.active ;;
    label: "Is Active"
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
    label: "Number of Payment Methods"
    drill_fields: [payment_method_id, payment_type, active, customer.customer_name]
  }

  measure: count_active {
    type: count
    label: "Active Payment Methods"
    filters: [active: "yes"]
  }

  measure: count_inactive {
    type: count
    label: "Inactive Payment Methods"
    filters: [active: "no"]
  }
}
