resource "azurerm_service_plan" "this" {
  name                = "${var.name}-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = var.sku_name
}

resource "azurerm_linux_web_app" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id

  identity {
    type = var.identity_type
  }

  site_config {
    application_stack {
      dotnet_version = "6.0"
    }
    always_on = false
  }

  app_settings = merge(var.app_settings, {
    WEBSITE_RUN_FROM_PACKAGE = 1
  })

  zip_deploy_file = var.zip_deploy_file

  tags = var.tags
}