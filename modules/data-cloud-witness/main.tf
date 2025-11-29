resource "azurerm_storage_account" "witness" {
  name                     = "cldwitness${random_string.suffix.result}"
  resource_group_name      = var.rg_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  allow_blob_public_access = false
}

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}
