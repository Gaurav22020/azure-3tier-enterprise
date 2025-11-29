resource "azurerm_network_interface" "web_nic" {
  count               = var.vm_count
  name                = "nic-web-${count.index}"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "nic_assoc" {
  count                   = var.vm_count
  network_interface_id    = azurerm_network_interface.web_nic[count.index].id
  ip_configuration_name   = "ipconfig1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.web_pool.id
}

resource "azurerm_linux_virtual_machine" "web_vm" {
  count               = var.vm_count
  name                = "vm-web-${count.index}"
  resource_group_name = var.rg_name
  location            = var.location
  size                = "Standard_B2ms" # safer choice

  admin_username                  = "webadmin"
  admin_password                  = "Admin@12345!" # change later
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.web_nic[count.index].id
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
