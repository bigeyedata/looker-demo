# E-commerce Analytics Model
# Connects to BigQuery via AtScale semantic layer

connection: "bigquery_atscale"

# Include all view files
include: "/views/**/*.view.lkml"
include: "/dashboards/**/*.dashboard.lkml"

# Datagroups for caching
datagroup: ecommerce_default_datagroup {
  sql_trigger: SELECT MAX(order_timestamp) FROM `bigeye-se-demo.tooy_demo_db.orders` ;;
  max_cache_age: "1 hour"
}

persist_with: ecommerce_default_datagroup

# ===========================
# EXPLORES
# ===========================

# Main Orders Explore
explore: orders {
  label: "Orders Analysis"
  description: "Comprehensive order analysis including customers, products, shipments, and payments"

  # Join to customer
  join: customer {
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders.customer_id} = ${customer.customer_id} ;;
    fields: [customer.customer_id, customer.customer_name, customer.email,
             customer.company_name, customer.company_city, customer.company_state,
             customer.count, customer.count_with_orders]
  }

  # Join to payment method
  join: payment_method {
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders.payment_method_id} = ${payment_method.payment_method_id} ;;
    fields: [payment_method.payment_type, payment_method.active,
             payment_method.count, payment_method.count_active]
  }

  # Join to shipment
  join: shipment {
    type: left_outer
    relationship: one_to_many
    sql_on: ${orders.order_id} = ${shipment.order_id} ;;
    fields: [shipment.tracking_number, shipment.status, shipment.status_timestamp_date,
             shipment.is_delivered, shipment.is_in_transit, shipment.count,
             shipment.count_delivered, shipment.count_in_transit]
  }

  # Join to product price (via product_type)
  join: product_price {
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders.product_type} = ${product_price.product_name} ;;
    fields: [product_price.product_name, product_price.base_price,
             product_price.average_price, product_price.count]
  }

  # Join to product stock (via product_type)
  join: product_stock {
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders.product_type} = ${product_stock.product_name} ;;
    fields: [product_stock.quantity, product_stock.stock_status,
             product_stock.is_low_stock, product_stock.count_low_stock,
             product_stock.total_quantity]
  }
}

# Customer Analytics Explore
explore: customer {
  label: "Customer Analytics"
  description: "Customer demographics, orders, and payment methods"

  # Join to orders for customer metrics
  join: orders {
    type: left_outer
    relationship: one_to_many
    sql_on: ${customer.customer_id} = ${orders.customer_id} ;;
    fields: [orders.order_id, orders.product_type, orders.order_date,
             orders.order_total, orders.count, orders.total_revenue,
             orders.average_order_value]
  }

  # Join to payment methods
  join: payment_method {
    type: left_outer
    relationship: one_to_many
    sql_on: ${customer.customer_id} = ${payment_method.customer_id} ;;
    fields: [payment_method.payment_type, payment_method.active,
             payment_method.count, payment_method.count_active]
  }

  # Join to shipment via orders
  join: shipment {
    type: left_outer
    relationship: one_to_many
    sql_on: ${orders.order_id} = ${shipment.order_id} ;;
    fields: [shipment.status, shipment.is_delivered, shipment.count,
             shipment.count_delivered]
  }
}

# Product Performance Explore
explore: product_price {
  label: "Product Performance"
  description: "Product pricing, inventory, and sales analysis"
  view_label: "Products"

  # Join to product stock
  join: product_stock {
    type: left_outer
    relationship: one_to_one
    sql_on: ${product_price.product_name} = ${product_stock.product_name} ;;
    fields: [product_stock.quantity, product_stock.stock_status,
             product_stock.is_low_stock, product_stock.is_out_of_stock,
             product_stock.count_low_stock, product_stock.count_out_of_stock,
             product_stock.total_quantity, product_stock.average_quantity]
  }

  # Join to orders for sales metrics
  join: orders {
    type: left_outer
    relationship: one_to_many
    sql_on: ${product_price.product_name} = ${orders.product_type} ;;
    fields: [orders.order_date, orders.quantity, orders.count,
             orders.total_quantity, orders.total_revenue,
             orders.average_order_value]
  }
}

# Shipment Tracking Explore
explore: shipment {
  label: "Shipment Tracking"
  description: "Shipment status and delivery tracking"

  # Join to orders
  join: orders {
    type: left_outer
    relationship: many_to_one
    sql_on: ${shipment.order_id} = ${orders.order_id} ;;
    fields: [orders.order_id, orders.product_type, orders.order_date,
             orders.order_total, orders.shipping_city, orders.shipping_state,
             orders.count, orders.total_revenue]
  }

  # Join to customer via orders
  join: customer {
    type: left_outer
    relationship: many_to_one
    sql_on: ${orders.customer_id} = ${customer.customer_id} ;;
    fields: [customer.customer_id, customer.customer_name, customer.email,
             customer.company_name, customer.count]
  }
}
