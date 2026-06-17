variable "name" {
  description = "Nombre del App Service"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "sku_name" {
  description = "SKU del App Service Plan"
  type        = string
  default     = "B1"
}

variable "identity_type" {
  description = "Tipo de identidad: SystemAssigned, UserAssigned, o None"
  type        = string
  default     = "SystemAssigned"
}

variable "app_settings" {
  description = "Configuraciones de la aplicación"
  type        = map(string)
  default     = {}
}

variable "zip_deploy_file" {
  description = "Ruta al archivo ZIP para desplegar"
  type        = string
  default     = null
}

variable "tags" {
  type = map(string)
  default = {}
}