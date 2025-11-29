resource "azurerm_lb" "biz_ilb" {
  name                = "ilb-biz-tier"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "biz-ilb-fe"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.4.10" # Biz Tier Private LB
  }
}

resource "azurerm_lb_backend_address_pool" "biz_pool" {
  name            = "biz-backend-pool"
  loadbalancer_id = azurerm_lb.biz_ilb.id
}

resource "azurerm_lb_probe" "probe_8080" {
  name            = "biz-probe-8080"
  loadbalancer_id = azurerm_lb.biz_ilb.id
  port            = 8080
  protocol        = "Tcp"
}

resource "azurerm_lb_rule" "biz_rule" {
  name                           = "biz-rule-8080"
  loadbalancer_id                = azurerm_lb.biz_ilb.id
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 8080
  frontend_ip_configuration_name = "biz-ilb-fe"
  probe_id                       = azurerm_lb_probe.probe_8080.id
}
