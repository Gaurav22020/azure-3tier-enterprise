output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "subnet_ids" {
  value = {
    appgw = azurerm_subnet.appgw.id
    mgmt  = azurerm_subnet.mgmt.id
    web   = azurerm_subnet.web.id
    biz   = azurerm_subnet.biz.id
    data  = azurerm_subnet.data.id
    ad    = azurerm_subnet.ad.id
  }
}
