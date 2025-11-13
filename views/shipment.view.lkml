view: shipment {
  sql_table_name: `bigeye-se-demo.tooy_demo_db.shipment` ;;
  label: "Shipments"

  # Primary Key
  dimension: shipment_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.shipment_id ;;
    label: "Shipment ID"
  }

  # Foreign Keys
  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
    label: "Order ID"
    hidden: yes
  }

  # Tracking Information
  dimension: tracking_number {
    type: string
    sql: ${TABLE}.tracking_number ;;
    label: "Tracking Number"
  }

  # Status
  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
    label: "Shipping Status"
  }

  # Timestamp
  dimension_group: status_timestamp {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.status_timestamp ;;
    label: "Status Date"
  }

  # Derived Dimensions
  dimension: days_since_status_update {
    type: number
    sql: DATE_DIFF(CURRENT_DATE(), DATE(${status_timestamp_raw}), DAY) ;;
    label: "Days Since Status Update"
  }

  dimension: is_delivered {
    type: yesno
    sql: LOWER(${status}) = 'delivered' ;;
    label: "Is Delivered"
  }

  dimension: is_in_transit {
    type: yesno
    sql: LOWER(${status}) IN ('shipped', 'in_transit', 'out_for_delivery') ;;
    label: "Is In Transit"
  }

  # Measures
  measure: count {
    type: count
    label: "Number of Shipments"
    drill_fields: [shipment_id, tracking_number, status, orders.order_id, orders.customer.customer_name]
  }

  measure: count_delivered {
    type: count
    label: "Delivered Shipments"
    filters: [is_delivered: "yes"]
  }

  measure: count_in_transit {
    type: count
    label: "Shipments In Transit"
    filters: [is_in_transit: "yes"]
  }

  measure: average_days_since_update {
    type: average
    sql: ${days_since_status_update} ;;
    label: "Average Days Since Status Update"
    value_format_name: decimal_1
  }
}
