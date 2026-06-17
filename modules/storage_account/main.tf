resource "azurerm_storage_account" "this" {
  name                     = var.name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = var.tags
}

resource "azurerm_storage_container" "this" {
  for_each = var.containers
  name                  = each.key
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}