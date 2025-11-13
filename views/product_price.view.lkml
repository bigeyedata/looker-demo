view: product_price {
  sql_table_name: `bigeye-se-demo.tooy_demo_db.product_price` ;;
  label: "Product Prices"

  # Primary Key
  dimension: product_name {
    type: string
    primary_key: yes
    sql: ${TABLE}.product_name ;;
    label: "Product Name"
  }

  # Price
  dimension: base_price {
    type: number
    sql: ${TABLE}.base_price ;;
    label: "Base Price"
    value_format_name: usd
  }

  # Timestamp
  dimension_group: price_set {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.price_set_timestamp ;;
    label: "Price Set Date"
  }

  # Measures
  measure: count {
    type: count
    label: "Number of Products"
    drill_fields: [product_name, base_price, price_set_date]
  }

  measure: average_price {
    type: average
    sql: ${base_price} ;;
    label: "Average Product Price"
    value_format_name: usd
  }

  measure: min_price {
    type: min
    sql: ${base_price} ;;
    label: "Minimum Price"
    value_format_name: usd
  }

  measure: max_price {
    type: max
    sql: ${base_price} ;;
    label: "Maximum Price"
    value_format_name: usd
  }

  measure: total_inventory_value {
    type: sum
    sql: ${base_price} * ${product_stock.quantity} ;;
    label: "Total Inventory Value"
    value_format_name: usd
  }
}
