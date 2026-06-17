output "dev_resource_group_name" {
  value = module.rg.name
}

output "dev_app_service_url" {
  value = "https://${module.appservice.default_hostname}"
}

output "dev_key_vault_uri" {
  value = module.keyvault.vault_uri
}

output "dev_summary" {
  value = <<-EOT
    ✅ LABORATORIO 3 - WORKLOAD IDENTITY FEDERATION (DEV) DESPLEGADO
    
    🌐 App Service URL: https://${module.appservice.default_hostname}
    🔐 Key Vault URI: ${module.keyvault.vault_uri}
    📁 Storage Endpoint: ${module.storage.primary_blob_endpoint}
    
    💡 Este laboratorio usa Workload Identity Federation.
    🔑 GitHub Actions se autentica sin secretos usando OIDC.
  EOT
}