module "rg" {
  source              = "./modules/resourcegroup"
  resource_group_name = "rg-3tier-enterprise"
  location            = "eastus"
}

module "network" {
  source       = "./modules/network"
  rg_name      = module.rg.resource_group_name
  location     = module.rg.location
  ddos_plan_id = module.ddos.ddos_plan_id
  depends_on   = [module.rg]
}
module "ddos" {
  source     = "./modules/security-Ddos"
  rg_name    = module.rg.resource_group_name
  location   = module.rg.location
  depends_on = [module.rg]
}

module "nsg" {
  source     = "./modules/networksecurity"
  rg_name    = module.rg.resource_group_name
  location   = module.rg.location
  subnet_ids = module.network.subnet_ids
  depends_on = [module.network]
}
module "app_gateway" {
  source       = "./modules/security-appgw"
  rg_name      = module.rg.rg_name
  location     = module.rg.rg_location
  appgw_subnet = module.network.subnet_ids.appgw
  backend_ip   = "10.0.3.10" # Web internal LB IP (fixed)
}
