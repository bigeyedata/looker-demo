- dashboard: ecommerce_overview
  title: E-commerce Overview
  layout: newspaper
  preferred_viewer: dashboards-next
  description: "Executive overview of e-commerce performance with key metrics and trends"

  elements:
  # KPI Tiles
  - name: total_revenue
    title: Total Revenue
    model: ecommerce
    explore: orders
    type: single_value
    fields: [orders.total_revenue]
    limit: 500
    listen:
      Date Range: orders.order_date
    row: 0
    col: 0
    width: 6
    height: 4

  - name: total_orders
    title: Total Orders
    model: ecommerce
    explore: orders
    type: single_value
    fields: [orders.count]
    limit: 500
    listen:
      Date Range: orders.order_date
    row: 0
    col: 6
    width: 6
    height: 4

  - name: average_order_value
    title: Average Order Value
    model: ecommerce
    explore: orders
    type: single_value
    fields: [orders.average_order_value]
    limit: 500
    listen:
      Date Range: orders.order_date
    row: 0
    col: 12
    width: 6
    height: 4

  - name: total_customers
    title: Total Customers
    model: ecommerce
    explore: orders
    type: single_value
    fields: [customer.count]
    limit: 500
    listen:
      Date Range: orders.order_date
    row: 0
    col: 18
    width: 6
    height: 4

  # Revenue Trend Chart
  - name: revenue_trend
    title: Revenue Trend Over Time
    model: ecommerce
    explore: orders
    type: looker_line
    fields: [orders.order_date, orders.total_revenue, orders.count]
    fill_fields: [orders.order_date]
    sorts: [orders.order_date desc]
    limit: 500
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    listen:
      Date Range: orders.order_date
    row: 4
    col: 0
    width: 12
    height: 8

  # Orders by Product Type
  - name: orders_by_product
    title: Orders by Product Type
    model: ecommerce
    explore: orders
    type: looker_bar
    fields: [orders.product_type, orders.count, orders.total_revenue]
    sorts: [orders.total_revenue desc]
    limit: 10
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    show_null_points: true
    interpolation: linear
    listen:
      Date Range: orders.order_date
    row: 4
    col: 12
    width: 12
    height: 8

  # Top Customers
  - name: top_customers
    title: Top 10 Customers by Revenue
    model: ecommerce
    explore: orders
    type: looker_grid
    fields: [customer.customer_name, customer.email, customer.company_name, orders.count, orders.total_revenue, orders.average_order_value]
    sorts: [orders.total_revenue desc]
    limit: 10
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    listen:
      Date Range: orders.order_date
    row: 12
    col: 0
    width: 12
    height: 8

  # Shipment Status
  - name: shipment_status
    title: Shipment Status Overview
    model: ecommerce
    explore: orders
    type: looker_pie
    fields: [shipment.status, shipment.count]
    sorts: [shipment.count desc]
    limit: 500
    value_labels: legend
    label_type: labPer
    inner_radius: 50
    listen:
      Date Range: orders.order_date
    row: 12
    col: 12
    width: 6
    height: 8

  # Payment Method Distribution
  - name: payment_methods
    title: Payment Methods
    model: ecommerce
    explore: orders
    type: looker_pie
    fields: [payment_method.payment_type, orders.count]
    sorts: [orders.count desc]
    limit: 500
    value_labels: legend
    label_type: labPer
    listen:
      Date Range: orders.order_date
    row: 12
    col: 18
    width: 6
    height: 8

  # Low Stock Products Alert
  - name: low_stock_products
    title: Low Stock Products (< 10 units)
    model: ecommerce
    explore: orders
    type: looker_grid
    fields: [product_stock.product_name, product_stock.quantity, product_stock.stock_status, product_price.base_price]
    filters:
      product_stock.is_low_stock: 'yes'
    sorts: [product_stock.quantity]
    limit: 20
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: white
    limit_displayed_rows: false
    enable_conditional_formatting: true
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting:
    - type: less than
      value: 5
      background_color: "#EA4335"
      font_color:
      color_application:
        collection_id: google
        palette_id: google-sequential-0
      bold: false
      italic: false
      strikethrough: false
      fields:
    row: 20
    col: 0
    width: 12
    height: 8

  # Orders by State
  - name: orders_by_state
    title: Orders by Shipping State
    model: ecommerce
    explore: orders
    type: looker_geo_choropleth
    fields: [orders.shipping_state, orders.count, orders.total_revenue]
    sorts: [orders.count desc]
    limit: 500
    map: usa
    map_projection: ''
    show_view_names: false
    quantize_colors: false
    listen:
      Date Range: orders.order_date
    row: 20
    col: 12
    width: 12
    height: 8

  # Filters
  filters:
  - name: Date Range
    title: Date Range
    type: field_filter
    default_value: 30 days
    allow_multiple_values: true
    required: false
    ui_config:
      type: advanced
      display: popover
      options: []
    model: ecommerce
    explore: orders
    listens_to_filters: []
    field: orders.order_date
