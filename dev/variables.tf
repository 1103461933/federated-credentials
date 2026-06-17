variable "environment" {
  description = "Ambiente (dev/prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Región de Azure"
  type        = string
  default     = "canadacentral"
}

variable "prefix" {
  description = "Prefijo para recursos"
  type        = string
  default     = "wif"
}

variable "sku_name" {
  description = "SKU del App Service Plan"
  type        = string
  default     = "B1"
}

variable "tags" {
  description = "Tags comunes"
  type        = map(string)
  default = {
    Project     = "Lab3-WorkloadIdentity"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}