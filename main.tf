terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.89.0"
    }
  }
#   backend "azurerm" {
#     # resource_group_name = "test_rg_abhishek"
#     # storage_account_name = "demostorage121212"
#     # access_key = "cVFgNGJct2K6CoO/szz5q3yqiTiqsACLjD/CYAmDWuO/5GJH1fLu3fdFUKOozwXEcvo95X7f5MhW+AStbZ/sNg=="
#     # container_name = "tfstatecontainer"
#     # key = "terraform.tfstate"
#   }
}

provider "azurerm" {
    subscription_id = "521df5f2-f174-46cb-8363-4221f67e2238"
    tenant_id = "2bc58b70-9874-46bc-ae78-69a65ba1062f"
    client_id = "75c7ecb6-b906-406d-a5ec-6f7b6a22f923"
    client_secret = "nzu8Q~wE-Z0U8kpzEkPZxkljvjHd4AoH~Ebv2cuA"
    features {}
}

resource "azurerm_resource_group" "test_rg_abhishek" {
  name     = "rgnewrgone"
  location = "South India"
}

