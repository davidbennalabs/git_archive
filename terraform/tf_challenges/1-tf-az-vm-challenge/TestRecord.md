
# June 4th 2025
 Error: creating Linux Virtual Machine (Subscription: "7a30c575-d82b-4d81-af47-a5f124232c52"
│ Resource Group Name: "engineering-tf-challenge-1-dev-rg"
│ Virtual Machine Name: "tf-challenge-1-vm-1"): performing CreateOrUpdate: unexpected status 400 (400 Bad Request) with error: InvalidParameter: Destination path for SSH public keys is currently limited to its default value /home/azureadmin/.ssh/authorized_keys  due to a known issue in Linux provisioning agent.
│ 
│   with azurerm_linux_virtual_machine.my_terraform_vm,
│   on web_bastion_vm.tf line 24, in resource "azurerm_linux_virtual_machine" "my_terraform_vm":
│   24: resource "azurerm_linux_virtual_machine" "my_terraform_vm" {
│ 
FIXED MYIP
SSH issue.  Works on lab1-starter but not this stack

Weird error here using id_ed25519.pub 

# June 4th 2025

ssh to myip doesn't work.
changed to all ips. Fixes hitting ssh but
permission denied from ssh 
  - probably wrong key..