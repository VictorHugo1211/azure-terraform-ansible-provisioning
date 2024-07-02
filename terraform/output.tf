output "ip" {
  value = azurerm_public_ip.wordpress.ip_address
}

output "mysql_server_name" {
  value = azurerm_mysql_flexible_server.mysql-server.name
}