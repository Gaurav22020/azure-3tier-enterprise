resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.location
  resource_group_name = var.rg_name
  address_space       = [var.vnet_cidr]
  ddos_protection_plan {
    id     = var.ddos_plan_id
    enable = true
  }
}
