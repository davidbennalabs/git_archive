variable "username" {
  type        = string
  description = "The username for the local account that will be created on the new VM."
  default     = "azureadmin"
}

variable "vm_size" {
  type        = string
  description = "The size for the vms"
  default     = "Standard_B1s"
}

variable "admin_password" {}

