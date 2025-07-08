variable "myip" {
  description = "local ip"
  type        = string
}


variable "resource_group_location" {
  type        = string
  default     = "eastus"
  description = "Location of the resource group."
}

#variable "resource_group_name_prefix" {
variable "rg_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "bu" {
  type        = string
  description = "The business Unit for the tf resource"
  default     = "engineering"
}

variable "project" {
  type        = string
  description = "The business Unit for the tf resource"
  default     = "terraform"
}

