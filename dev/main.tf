data "azurerm_client_config" "current" {}

locals {
  rg_name          = "${var.prefix}-rg-${var.environment}"
  kv_name          = "${var.prefix}kv${var.environment}${random_integer.suffix.result}"
  app_name         = "${var.prefix}app${var.environment}${random_integer.suffix.result}"
  storage_name     = "${var.prefix}st${var.environment}${random_integer.suffix.result}"
}

resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}

# Resource Group
module "rg" {
  source = "../modules/resource-group"          # ✅ CORREGIDO
  name   = local.rg_name
  location = var.location
  tags = merge(var.tags, {
    Environment = var.environment
  })
}

# Key Vault
module "keyvault" {
  source = "../modules/key-vault"               # ✅ CORREGIDO
  name   = local.kv_name
  location = module.rg.location
  resource_group_name = module.rg.name
  tenant_id = data.azurerm_client_config.current.tenant_id
  user_object_id = data.azurerm_client_config.current.object_id
  secrets = {
    "DatabaseConnection" = "Server=tcp:dev-server.database.windows.net,1433;Database=devdb;"
    "ApiKey"             = "dev-api-key-12345"
  }
  tags = merge(var.tags, {
    Environment = var.environment
  })
}

# Storage Account
module "storage" {
  source = "../modules/storage_account"         # ✅ CORRECTO (ya estaba bien)
  name   = local.storage_name
  resource_group_name = module.rg.name
  location = module.rg.location
  containers = {
    "dev-uploads" = "Contenedor DEV para archivos"
    "dev-backups" = "Contenedor DEV para backups"
  }
  tags = merge(var.tags, {
    Environment = var.environment
  })
}

# App Service
module "appservice" {
  source = "../modules/app-service"             # ✅ CORREGIDO
  name                = local.app_name
  location            = module.rg.location
  resource_group_name = module.rg.name
  identity_type       = "SystemAssigned"
  sku_name            = var.sku_name
  app_settings = {
    "KeyVaultUri"    = module.keyvault.vault_uri
    "StorageAccount" = module.storage.primary_blob_endpoint
    "Environment"    = var.environment
  }
  tags = merge(var.tags, {
    Environment = var.environment
  })
}

# Permisos de Managed Identity - Key Vault
resource "azurerm_key_vault_access_policy" "app_to_kv" {
  key_vault_id = module.keyvault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.appservice.principal_id

  secret_permissions = [
    "Get",
    "List"
  ]
}

# Permisos de Managed Identity - Storage Account
resource "azurerm_role_assignment" "app_to_storage" {
  principal_id         = module.appservice.principal_id
  role_definition_name = "Storage Blob Data Reader"
  scope                = module.storage.id
}