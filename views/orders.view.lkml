view: orders {
  sql_table_name: `bigeye-se-demo.tooy_demo_db.orders` ;;
  label: "Orders"

  # Primary Key
  dimension: order_id {
    type: number
    primary_key: yes
    sql: ${TABLE}.order_id ;;
    label: "Order ID"
  }

  # Foreign Keys
  dimension: customer_id {
    type: number
    sql: ${TABLE}.customer_id ;;
    label: "Customer ID"
    hidden: yes
  }

  dimension: payment_method_id {
    type: number
    sql: ${TABLE}.payment_method_id ;;
    label: "Payment Method ID"
    hidden: yes
  }

  # Product Information
  dimension: product_type {
    type: string
    sql: ${TABLE}.product_type ;;
    label: "Product Type"
  }

  # Quantity and Price
  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
    label: "Quantity"
  }

  dimension: price_per_unit {
    type: number
    sql: ${TABLE}.price_per_unit ;;
    label: "Price Per Unit"
    value_format_name: usd
  }

  # Shipping Address
  dimension: shipping_address_line_1 {
    type: string
    sql: ${TABLE}.shipping_address_line_1 ;;
    label: "Shipping Address Line 1"
  }

  dimension: shipping_address_line_2 {
    type: string
    sql: ${TABLE}.shipping_address_line_2 ;;
    label: "Shipping Address Line 2"
  }

  dimension: shipping_city {
    type: string
    sql: ${TABLE}.shipping_city ;;
    label: "Shipping City"
  }

  dimension: shipping_state {
    type: string
    sql: ${TABLE}.shipping_state ;;
    label: "Shipping State"
  }

  dimension: shipping_zip {
    type: string
    sql: ${TABLE}.shipping_zip ;;
    label: "Shipping ZIP"
  }

  dimension: full_shipping_address {
    type: string
    sql: CONCAT(${shipping_address_line_1}, ', ', ${shipping_city}, ', ', ${shipping_state}, ' ', ${shipping_zip}) ;;
    label: "Full Shipping Address"
  }

  # Timestamps
  dimension_group: order {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.order_timestamp ;;
    label: "Order Date"
  }

  # Derived Dimensions
  dimension: order_total {
    type: number
    sql: ${quantity} * ${price_per_unit} ;;
    label: "Order Total"
    value_format_name: usd
  }

  # Measures
  measure: count {
    type: count
    label: "Number of Orders"
    drill_fields: [order_id, customer.customer_name, product_type, order_total, order_date]
  }

  measure: total_quantity {
    type: sum
    sql: ${quantity} ;;
    label: "Total Quantity Sold"
  }

  measure: total_revenue {
    type: sum
    sql: ${quantity} * ${price_per_unit} ;;
    label: "Total Revenue"
    value_format_name: usd
  }

  measure: average_order_value {
    type: average
    sql: ${quantity} * ${price_per_unit} ;;
    label: "Average Order Value"
    value_format_name: usd
  }

  measure: average_price_per_unit {
    type: average
    sql: ${price_per_unit} ;;
    label: "Average Price Per Unit"
    value_format_name: usd
  }

  measure: average_quantity {
    type: average
    sql: ${quantity} ;;
    label: "Average Quantity Per Order"
    value_format_name: decimal_2
  }
}
