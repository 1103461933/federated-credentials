variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "user_object_id" {
  description = "Object ID del usuario que ejecuta Terraform"
  type        = string
}

variable "secrets" {
  description = "Mapa de secretos a crear"
  type        = map(string)
  default     = {}
}

variable "tags" {
  type = map(string)
  default = {}
}