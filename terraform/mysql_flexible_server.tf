resource "azurerm_mysql_flexible_server" "mysql-server" {
  name                = var.db_server_name
  location            = azurerm_resource_group.wordpress.location
  resource_group_name = azurerm_resource_group.wordpress.name
  version             = "5.7"
  zone                = "1"

  administrator_login    = var.admin_db
  administrator_password = var.admin_password_db

  sku_name = "B_Standard_B1s"

  backup_retention_days = 7

  delegated_subnet_id = azurerm_subnet.wordpress_db.id
  private_dns_zone_id = null
}

resource "azurerm_mysql_flexible_server_configuration" "mysql-server" {
  name                = "require_secure_transport"
  resource_group_name = azurerm_resource_group.wordpress.name
  server_name         = azurerm_mysql_flexible_server.mysql-server.name
  value               = "OFF"
}

resource "azurerm_mysql_flexible_database" "mysql-db" {
  name                = var.db_name
  resource_group_name = azurerm_resource_group.wordpress.name
  server_name         = azurerm_mysql_flexible_server.mysql-server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_flexible_server_firewall_rule" "mysql-firewall" {
  name                = "wordpress-mysql-firewall-rule"
  resource_group_name = azurerm_resource_group.wordpress.name
  server_name         = azurerm_mysql_flexible_server.mysql-server.name
  start_ip_address    = azurerm_public_ip.wordpress.ip_address
  end_ip_address      = azurerm_public_ip.wordpress.ip_address
}
