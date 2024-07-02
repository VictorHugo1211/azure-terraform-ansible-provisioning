resource "azurerm_linux_virtual_machine" "wordpress" {
  name                = "vm-wordpress"
  location            = var.location
  resource_group_name = azurerm_resource_group.wordpress.name
  size                = "Standard_B2s"
  admin_username      = var.admin_vm
  #admin_password = var.admin_password_vm
  network_interface_ids = [
    azurerm_network_interface.wordpress.id,
  ]

  admin_ssh_key {
    username   = var.admin_vm
    public_key = file(var.public_key_path)
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  connection {
    host        = azurerm_public_ip.wordpress.ip_address
    type        = "ssh"
    user        = var.admin_vm
    private_key = file(var.public_key_path)
  }

  depends_on = [azurerm_mysql_flexible_server.mysql-server]
}
