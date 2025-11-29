variable "rg_name" { type = string }
variable "location" { type = string }
variable "subnet_id" { type = string }

variable "vm_count" {
  type    = number
  default = 2
}
