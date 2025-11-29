output "nsg_ids" {
  value = {
    appgw = azurerm_network_security_group.nsg_appgw.id
    mgmt  = azurerm_network_security_group.nsg_mgmt.id
    web   = azurerm_network_security_group.nsg_web.id
    biz   = azurerm_network_security_group.nsg_biz.id
    data  = azurerm_network_security_group.nsg_data.id
    ad    = azurerm_network_security_group.nsg_ad.id
  }
}
