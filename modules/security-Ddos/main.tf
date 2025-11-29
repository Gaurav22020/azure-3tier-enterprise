resource "azurerm_network_ddos_protection_plan" "ddos" {
  name                = var.ddos_name
  location            = var.location
  resource_group_name = var.rg_name
}
