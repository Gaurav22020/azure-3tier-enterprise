resource "azurerm_lb" "web_ilb" {
  name                = "ilb-web-tier"
  location            = var.location
  resource_group_name = var.rg_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "web-ilb-fe"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.3.10" # FIXED BACKEND TARGET FOR APPGW
  }
}

resource "azurerm_lb_backend_address_pool" "web_pool" {
  name            = "web-backend-pool"
  loadbalancer_id = azurerm_lb.web_ilb.id
}

resource "azurerm_lb_probe" "probe_80" {
  name            = "web-probe-80"
  loadbalancer_id = azurerm_lb.web_ilb.id
  port            = 80
  protocol        = "Tcp"
}

resource "azurerm_lb_rule" "web_rule" {
  name                           = "web-rule-80"
  loadbalancer_id                = azurerm_lb.web_ilb.id
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "web-ilb-fe"
  probe_id                       = azurerm_lb_probe.probe_80.id
}
