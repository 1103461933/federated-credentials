variable "name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
  default     = "canadacentral"
}

variable "tags" {
  description = "Tags para el resource group"
  type        = map(string)
  default     = {}
}