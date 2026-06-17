output "id" {
  value = azurerm_linux_web_app.this.id
}

output "principal_id" {
  description = "ID de la Managed Identity"
  value       = azurerm_linux_web_app.this.identity[0].principal_id
}

output "default_hostname" {
  value = azurerm_linux_web_app.this.default_hostname
}

output "name" {
  value = azurerm_linux_web_app.this.name
}