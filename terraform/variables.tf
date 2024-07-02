variable "location" {
  description = "Location for the resources"
  type        = string
  default     = "brazilsouth"
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "wp-rg"
}

variable "admin_vm" {
  description = "The admin username for the VM"
  type        = string
}

variable "admin_password_vm" {
  description = "The admin password for the VM"
  type        = string
}

variable "public_key_path" {
  description = "The path to the SSH public key"
  type        = string
}

variable "admin_db" {
  description = "The admin username for the database"
  type        = string
}

variable "admin_password_db" {
  description = "The admin password for the database"
  type        = string
}

variable "db_name" {
  description = "The name of the database"
  type        = string
}

variable "db_server_name" {
  description = "The name of the MySQL server"
  type        = string
}