view: product_stock {
  sql_table_name: `bigeye-se-demo.tooy_demo_db.product_stock` ;;
  label: "Product Stock"

  # Primary Key
  dimension: product_name {
    type: string
    primary_key: yes
    sql: ${TABLE}.product_name ;;
    label: "Product Name"
  }

  # Quantity
  dimension: quantity {
    type: number
    sql: ${TABLE}.quantity ;;
    label: "Stock Quantity"
  }

  # Stock Status
  dimension: stock_status {
    type: string
    sql: CASE
           WHEN ${quantity} = 0 THEN 'Out of Stock'
           WHEN ${quantity} < 10 THEN 'Low Stock'
           WHEN ${quantity} < 50 THEN 'Medium Stock'
           ELSE 'High Stock'
         END ;;
    label: "Stock Status"
  }

  dimension: is_low_stock {
    type: yesno
    sql: ${quantity} < 10 ;;
    label: "Is Low Stock"
  }

  dimension: is_out_of_stock {
    type: yesno
    sql: ${quantity} = 0 ;;
    label: "Is Out of Stock"
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
    label: "Number of Products in Stock"
    drill_fields: [product_name, quantity, stock_status]
  }

  measure: total_quantity {
    type: sum
    sql: ${quantity} ;;
    label: "Total Stock Quantity"
  }

  measure: average_quantity {
    type: average
    sql: ${quantity} ;;
    label: "Average Stock Quantity"
    value_format_name: decimal_2
  }

  measure: count_low_stock {
    type: count
    label: "Low Stock Products"
    filters: [is_low_stock: "yes"]
  }

  measure: count_out_of_stock {
    type: count
    label: "Out of Stock Products"
    filters: [is_out_of_stock: "yes"]
  }
}
