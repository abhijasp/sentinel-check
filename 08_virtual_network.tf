# Create Virtual Network
resource "azurerm_virtual_network" "aksvnet" {
  name                = "aks-network"
  location            = azurerm_resource_group.test_rg_abhishek.location
  resource_group_name = azurerm_resource_group.test_rg_abhishek.name
  address_space       = ["10.4.0.0/18"]
}

# Create a Subnet for AKS
resource "azurerm_subnet" "aks-default" {
  name                 = "aks-default-subnet"
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = azurerm_resource_group.test_rg_abhishek.name
  address_prefixes     = ["10.4.1.0/24"]
}

# resource "azurerm_subnet" "postgresql-db-default" {
#   name                 = "postgresql-db-default-subnet"
#   virtual_network_name = azurerm_virtual_network.aksvnet.name
#   resource_group_name  = azurerm_resource_group.aks_rg.name
#   address_prefixes     = ["10.4.2.0/24"]
#   service_endpoints    = ["Microsoft.Sql"]
# }

# resource "azurerm_postgresql_virtual_network_rule" "postgresql-vnet-rule" {
#   name                                 = "postgresql-vnet-rule"
#   resource_group_name                  = azurerm_resource_group.aks_rg.name
#   server_name                          = azurerm_postgresql_server.postgresql_dev_and_qa.name
#   subnet_id                            = azurerm_subnet.postgresql-db-default.id
#   ignore_missing_vnet_service_endpoint = true
# }


resource "azurerm_subnet" "new-pgsql-retail-subnet" {
  name                 = "new-pgsql-retail-subnet"
  resource_group_name  = azurerm_resource_group.test_rg_abhishek.name
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  address_prefixes     = ["10.4.2.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

resource "azurerm_private_dns_zone" "pgsql-retailerp" {
  name                = "retailerp2.private.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.test_rg_abhishek.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "pgsql-retailerp-dns-vnet-link" {
  name                  = "retailerp2ventlink.com"
  private_dns_zone_name = azurerm_private_dns_zone.pgsql-retailerp.name
  virtual_network_id    = azurerm_virtual_network.aksvnet.id
  resource_group_name   = azurerm_resource_group.test_rg_abhishek.name
  depends_on            = [azurerm_subnet.new-pgsql-retail-subnet]
}


