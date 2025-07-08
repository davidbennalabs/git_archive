# Linux VM Input Variables Placeholder file.
variable "web_vm_size" {
  type        = string
  description = "The size for the vms"
  default     = "Standard_B1s"
}

variable "web_linuxvm_instance_count" {
  description = "Web Linux VM Instance Count"
  type        = number
  default     = 1
}

variable "lb_inbound_nat_ports" {
  description = "We LB Inbound Ports"
  type        = list(string)
  default     = ["1022", "2022", "3022", "4022", "5022"]
}
