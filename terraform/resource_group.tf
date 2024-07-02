resource "azurerm_resource_group" "wordpress" {
  name     = var.resource_group_name
  location = var.location
}