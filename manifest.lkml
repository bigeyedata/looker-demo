# Looker Project Manifest
# This file defines project-level settings and includes

project_name: "atscale_ecommerce_analytics"

# Localization Settings
localization_settings: {
  default_locale: en
  localization_level: permissive
}

# Constants
constant: ENVIRONMENT {
  value: "production"
  export: override_optional
}

constant: FISCAL_YEAR_START_MONTH {
  value: "1"
  export: override_optional
}

# Application configuration
application: looker_ecommerce_app {
  label: "E-commerce Analytics"
  url: "https://localhost:8080/bundle.js"
  entitlements: {
    core_api_methods: ["me", "all_lookml_models", "run_inline_query"]
    navigation: yes
    use_embeds: yes
    use_form_submit: yes
    use_clipboard: yes
    external_api_urls: ["https://api.atscale.com/*"]
  }
}