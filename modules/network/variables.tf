variable "rg_name" { type = string }
variable "location" { type = string }

variable "vnet_name" {
  type    = string
  default = "vnet-3tier-enterprise"
}

variable "vnet_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnets" {
  type = object({
    appgw = string
    mgmt  = string
    web   = string
    biz   = string
    data  = string
    ad    = string
  })
  default = {
    appgw = "10.0.1.0/24"
    mgmt  = "10.0.2.0/24"
    web   = "10.0.3.0/24"
    biz   = "10.0.4.0/24"
    data  = "10.0.5.0/24"
    ad    = "10.0.6.0/24"
  }
}
variable "ddos_plan_id" {
  type = string


}
