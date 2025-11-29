output "biz_ilb_ip" {
  value = azurerm_lb.biz_ilb.frontend_ip_configuration[0].private_ip_address
}
