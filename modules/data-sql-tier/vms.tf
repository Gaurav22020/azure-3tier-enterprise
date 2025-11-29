resource "azurerm_network_interface" "sqlnic" {
  count               = var.vm_count
  name                = "nic-sql-${count.index}"
  location            = var.location
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "sqlvm" {
  count               = var.vm_count
  name                = "vm-sql-${count.index}"
  location            = var.location
  resource_group_name = var.rg_name
  size                = "Standard_A1_v2" # IMPORTANT (quota safe)

  admin_username                  = "sqladmin"
  admin_password                  = "Admin@12345!"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.sqlnic[count.index].id
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
