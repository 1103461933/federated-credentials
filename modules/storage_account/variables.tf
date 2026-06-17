variable "name" {
  description = "Nombre del Storage Account"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del Resource Group"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
}

variable "containers" {
  description = "Mapa de contenedores a crear"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags para el Storage Account"
  type        = map(string)
  default     = {}
}