# Bastion Linux VM Input Variables Placeholder file.
variable "bastion_service_subnet_name" {
  description = "Bastion Service Subnet Name"
  default     = "AzureBastionSubnet"
}

variable "bastion_service_address_prefixes" {
  description = "Bastion Service Address Prefixes"
  default     = ["10.0.101.0/27"]
}

variable "vm_size" {
  type        = string
  description = "The size for the vms"
  default     = "Standard_B1s"
}

# variable "vm_size" {
#   type        = string
#   description = "The size for the vms"
#   default     = "Standard_B1s"
# }
