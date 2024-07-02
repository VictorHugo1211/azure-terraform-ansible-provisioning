resource "azurerm_network_interface" "wordpress" {
  name                = "wordpress-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.wordpress.name

  ip_configuration {
    name                          = "wordpress-ip-config"
    subnet_id                     = azurerm_subnet.wordpress_vm.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.wordpress.id
  }
}

resource "azurerm_network_interface_security_group_association" "wordpress_vm" {
  network_interface_id      = azurerm_network_interface.wordpress.id
  network_security_group_id = azurerm_network_security_group.wordpress_vm.id
}
