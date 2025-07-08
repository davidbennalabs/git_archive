## Step 1

- copy .bashrc file to bastion
- modiyfy ssh keys to use you local person key
   - make ssh `ssh-keygen -t rsa `
     enter as name of file `/home/david/.ssh/aztflabs_rsa` 
- keep web a redhat
- change bastion as ubuntu with variable vm_size 
  default     = "Standard_B1s"

- generate second ssh key for linux web.  This is so you can put the private key on bastion.  
  - bastion must use different pub/priv key then web. 
  - web is only accessible via of bastion for ssh



# Set CLI Authentication

See [ Tf cli logon](./https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli)

```
export ARM_SUBSCRIPTION_ID=$(az account show|jq .id|sed 's/"/'/g)
az account set --subscription=$ARM_SUBSCRIPTION_ID 

tf plan -out tfplan

```

## CONNECTING TO BASTION and WEB Server

- ssh bastion -> web 

```
curl localhost

# read cloud init logs

# list logs
ll /var/log/cloud*

grep -n systemctl  /var/log/cloud-init.log 
vi /var/log/cloud-init-output.log 

journalctl -u cloud-final



```

## FUTURE
- come up with vm variable strategy so uses on tf file for all vms.

    - small
    - medium
    - large
- use terraform.tfvars file to set values
- add nginx to redhat instance








##########




variable "vm_size" {
  type        = string
  description = "The size for the vms"
  default     = "Standard_B1s"
}















 ######
 
 You should have finished Section 12 Terraform.  

- Copy finished folder to step1-bastion/terraform-manifest

- Modify
  - MyIP
  - Resource Version
  - modify VM tye
  - CP your local ssh key to ssh-keys folder
    - MAKE SURE they are not ckecked into git. Update .gitignore

 ```
 variable "vm_size" {
  type        = string
  description = "The size for the vms"
  default     = "Standard_B1s"
}

## Change to ubuntu and instance size
## Add Bood diagnostics to storage
public_key = file("${path.module}/ssh-keys/id_ed25519.pub")
p
# Resource-3: Azure Linux Virtual Machine - Bastion Host
resource "azurerm_linux_virtual_machine" "bastion_host_linuxvm" {
  name = "${local.resource_name_prefix}-bastion-linuxvm"
  #computer_name = "bastionlinux-vm"  # Hostname of the VM (Optional)
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  #size = "Standard_DS1_v2"
  size                  = var.vm_size
  admin_username = "azureuser"
  network_interface_ids = [ azurerm_network_interface.bastion_host_linuxvm_nic.id ]
  admin_ssh_key {
    username = "azureuser"
    # modified
    public_key = file("${path.module}/ssh-keys/id_ed25519.pub")
  }
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_storage_account.primary_blob_endpoint
  }
}


```
# Set CLI Authentication

See [ Tf cli logon](./https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli)

```
export ARM_SUBSCRIPTION_ID=$(az account show|jq .id|sed 's/"/'/g)
az account set --subscription=$ARM_SUBSCRIPTION_ID 

tf plan -out tfplan

```