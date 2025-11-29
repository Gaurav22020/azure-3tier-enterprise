variable "rg_name" { type = string }
variable "location" { type = string }
variable "appgw_subnet" { type = string } # from network module
variable "backend_ip" { type = string }   # Web ILB private IP
