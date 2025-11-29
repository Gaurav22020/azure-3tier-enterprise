output "web_ilb_ip" {
  value = azurerm_lb.web_ilb.frontend_ip_configuration[0].private_ip_address
}
