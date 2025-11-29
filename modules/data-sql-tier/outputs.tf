output "sql_vm_private_ips" {
  value = [for n in azurerm_network_interface.sqlnic : n.ip_configuration[0].private_ip_address]
}
