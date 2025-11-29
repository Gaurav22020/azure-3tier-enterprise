# 1) Application Gateway Subnet NSG
resource "azurerm_network_security_group" "nsg_appgw" {
  name                = "nsg-appgw"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "allow_port_80_internet"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_port_443_internet"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "appgw_assoc" {
  subnet_id                 = var.subnet_ids.appgw
  network_security_group_id = azurerm_network_security_group.nsg_appgw.id
}


# 2) Management / Jumpbox NSG
resource "azurerm_network_security_group" "nsg_mgmt" {
  name                = "nsg-mgmt"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "allow_admin_only"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_address_prefix      = "192.168.1.8/32"
    destination_address_prefix = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "mgmt_assoc" {
  subnet_id                 = var.subnet_ids.mgmt
  network_security_group_id = azurerm_network_security_group.nsg_mgmt.id
}


# 3) Web Tier NSG
resource "azurerm_network_security_group" "nsg_web" {
  name                = "nsg-web"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "allow_from_appgw_80"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "AzureLoadBalancer"
    destination_port_range     = "80"
    source_port_range          = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "web_assoc" {
  subnet_id                 = var.subnet_ids.web
  network_security_group_id = azurerm_network_security_group.nsg_web.id
}


# 4) Business Tier NSG
# 4) Business Tier NSG
resource "azurerm_network_security_group" "nsg_biz" {
  name                = "nsg-biz"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "allow_from_web"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_address_prefix      = "10.0.1.0/24" # <-- Replace with actual Web Subnet
    destination_port_range     = "8080"
    source_port_range          = "*"
    destination_address_prefix = "*"
  }
}


resource "azurerm_subnet_network_security_group_association" "biz_assoc" {
  subnet_id                 = var.subnet_ids.biz
  network_security_group_id = azurerm_network_security_group.nsg_biz.id
}


# 5) Data Tier NSG (SQL Only Allowed)
resource "azurerm_network_security_group" "nsg_data" {
  name                = "nsg-data"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "allow_sql_from_biz"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    destination_port_range     = "1433"
    source_port_range          = "*"
    source_address_prefix      = "10.0.4.0/24" # Biz subnet
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "data_assoc" {
  subnet_id                 = var.subnet_ids.data
  network_security_group_id = azurerm_network_security_group.nsg_data.id
}



# 6) Active Directory NSG 
resource "azurerm_network_security_group" "nsg_ad" {
  name                = "nsg-ad"
  location            = var.location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "allow_kerberos"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "88"
    source_address_prefix      = "10.0.0.0/16"
    destination_address_prefix = "*"
  }
}


resource "azurerm_subnet_network_security_group_association" "ad_assoc" {
  subnet_id                 = var.subnet_ids.ad
  network_security_group_id = azurerm_network_security_group.nsg_ad.id
}
