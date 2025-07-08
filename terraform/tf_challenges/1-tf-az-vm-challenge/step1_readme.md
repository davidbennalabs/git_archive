# PHASE 1

We are using the files from the [Terraform VM quickstart files](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-terraform?tabs=azure-cli).   
These have been copied to [initial_manifests folder](./initial_manifests/) for your convenience


## See diagram.



### DAVES CHECK LIST
- [ ] Check SSH configt
- [ ] Check instance size configt
- [x] Draft the body
- [ ] Revise the conclusion

- [ ] add checkov
- [ ] mk modules 
  - network
  - db
  - container

## STEPS 

### INSTALL Terraform

[Click Link to Install Terraform](https://developer.hashicorp.com/terraform/install)  
Directions are pretty straight forward

```
# Optionally update .bashrc
vi ~/.bashrc
# go to bottom of file
# enter capital G
G 

# paste the items below
set -o vi

# optional, but handles long directory paths well
export PS1='\u@\W: '

alias k=kubectl
alias tf=terraform

### SAVE FILE and EXIT
esc 
:wq

# run file
. ~/.bashrc

```

### Step 1


### Create step1 folder and files

The files from the 
[Terraform VM quickstart files](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-terraform?tabs=azure-cli)  have been copied to [initial_manifests folder](./initial_manifests/)

```
# create staging directory to make modifications to files
cd step1
cp -pr initial_manifests stage_manifests
cd stage_manifests
mv main.tf main_net.tf

```

### Update Variables

```
## SHORTEN NAME
#variable "resource_group_name_prefix" {
variable "rg_prefix" {


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

variable "vm_size" {
  type        = string
  description = "The size for the vms"
  default     = "Standard_B1s"
}

# change vm resource to use var.vm_size

  #size                  = "Standard_DS1_v2"
  size                  = var.vm_size

```

## create tf workspace

Terraform workspaces are not for complex backends.  We are using them for the simple POC, but will not use them for more complex designs.

[Workspace Usage and Limitations](https://developer.hashicorp.com/terraform/cli/workspaces)
```
tf workspace new pro
tf workspace new dev

tf workspace list
# make sure using dev
tf workspace select dev

```

## Terraform manifest updates

```
resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  #name     = random_pet.rg_name.id
  name     = ${var.bu}-${var.project}-${terraform.workspace}-${var.rg_prefix}
}

```

## Run Terraform

```
az login
az group list |jq .[].name
tf fmt
tf init
tf plan -out tfplan

```

### USE CONSOLE FOR SSH ACCESS

Click on myVM resource and select connect using azure cli. This opens cloud shell. 

Cloud shell prints out az ssh vm  command as such

### BASIC az ssh login script

```
export SUBSCRIPTION=
export VM

az ssh vm --resource-group engineering-terraform-dev-rg --vm-name $VM --subscription $SUBSCRIPTION

davidbennalabs@outlook.com@hostname:~$ 

# copy keys.  NOT SURE IF PUBLIC IP IS CORRECT

```

There may be a better way to do this but I am not sure what I am missing.


### OPTIONALLY 

Change creating VM and use you local keys.

## Issues with reinstallation of ubuntu

```
# clear the account
az account clear
az config set core.enable_broker_on_windows=false
az login

```

## Future changes

Currently the subnet for dev and pro are the same.  They are in different resource groups so this works.  This should change once netwrok gets more complex.


Change backend to store state in cloud

ADD Containers
https://learn.microsoft.com/en-us/azure/developer/terraform/get-started-azapi-resource?tabs=azure-cli