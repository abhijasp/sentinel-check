resource "azurerm_postgresql_flexible_server" "pgsql-server" {
  name                   = "retailerp2"
  resource_group_name    = azurerm_resource_group.test_rg_abhishek.name
  location               = azurerm_resource_group.test_rg_abhishek.location
  version                = "16"
  delegated_subnet_id    = azurerm_subnet.new-pgsql-retail-subnet.id
  private_dns_zone_id    = azurerm_private_dns_zone.pgsql-retailerp.id
  administrator_login    = "psqladmin"
  administrator_password = "Abhi@12345"
  zone                   = "1"

  storage_mb = 32768

  sku_name   = "GP_Standard_D2s_v3"

  depends_on = [azurerm_private_dns_zone_virtual_network_link.pgsql-retailerp-dns-vnet-link]
}

# resource "azurerm_postgresql_flexible_server_database" "authtoken-postgresql-db-dev" {
#   name      = "authtoken-retailerp-dev"
#   server_id = azurerm_postgresql_flexible_server.pgsql-server.id
#   collation = "en_US.utf8"
#   charset   = "utf8"

#   # prevent the possibility of accidental data loss
#   lifecycle {
#     prevent_destroy = true
#   }
# }

resource "azurerm_postgresql_flexible_server_database" "authtoken-postgresql-db-qa" {
  name      = "authtoken-retailerp-qa"
  server_id = azurerm_postgresql_flexible_server.pgsql-server.id
  collation = "en_US.utf8"
  charset   = "utf8"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = true
  }
}