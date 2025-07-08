
## THIS CODE WORKS.  Manually copy index.html

data "azurerm_client_config" "current" {}

# Generate random resource group name
resource "random_pet" "rg_name" {
  prefix = var.resource_group_name_prefix
}

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = random_pet.rg_name.id
}

# Generate random value for the storage account name
resource "random_string" "storage_account_name" {
  length  = 8
  lower   = true
  numeric = false
  special = false
  upper   = false
}

resource "azurerm_storage_account" "storage_account" {
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location

  name = random_string.storage_account_name.result

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
}

resource "azurerm_storage_account_static_website" "name" {
  storage_account_id = azurerm_storage_account.storage_account.id
  error_404_document = "custom_not_found.html"
  index_document     = "index.html"
}
# resource "azurerm_storage_account_static_website" "static_website" {
#   storage_account_name = azurerm_storage_account.storage_account.name
#   resource_group_name  = azurerm_resource_group.rg.name

#   index_document = "index.html"
# }

locals {
  web_payload = {
    1 = "index.html"
    2 = "custom_not_found.html"
  }
}

resource "azurerm_storage_blob" "example" {
  for_each = local.web_payload
  #name                   = "index.html"
  name                   = each.value
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = each.value
}
