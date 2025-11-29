# Application Gateway Subnet
resource "azurerm_subnet" "appgw" {
  name                 = "snet-appgw"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnets.appgw]
}

# Management / Jumpbox Subnet
resource "azurerm_subnet" "mgmt" {
  name                 = "snet-mgmt"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnets.mgmt]
}

# Web Tier Subnet
resource "azurerm_subnet" "web" {
  name                 = "snet-web"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnets.web]
}

# Business Tier Subnet
resource "azurerm_subnet" "biz" {
  name                 = "snet-biz"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnets.biz]
}

# Data Tier Subnet (SQL Servers)
resource "azurerm_subnet" "data" {
  name                 = "snet-data"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnets.data]
}

# Active Directory Subnet
resource "azurerm_subnet" "ad" {
  name                 = "snet-ad"
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnets.ad]
}
