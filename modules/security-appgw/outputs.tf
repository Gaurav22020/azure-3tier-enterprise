output "appgw_public_ip" {
  value = azurerm_public_ip.appgw_pip.ip_address
}

output "appgw_frontend" {
  value = azurerm_application_gateway.appgw.frontend_ip_configuration[0].name
}
