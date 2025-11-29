resource "azurerm_network_interface" "biz_nic" {
  count               = var.vm_count
  name                = "nic-biz-${count.index}"
  resource_group_name = var.rg_name
  location            = var.location

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "biz_assoc" {
  count                   = var.vm_count
  network_interface_id    = azurerm_network_interface.biz_nic[count.index].id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.biz_pool.id
}

resource "azurerm_linux_virtual_machine" "biz_vms" {
  count               = var.vm_count
  name                = "vm-biz-${count.index}"
  resource_group_name = var.rg_name
  location            = var.location
  size                = "Standard_B2ms" # safe, same as web tier

  admin_username                  = "bizadmin"
  admin_password                  = "Admin@12345!"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.biz_nic[count.index].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
