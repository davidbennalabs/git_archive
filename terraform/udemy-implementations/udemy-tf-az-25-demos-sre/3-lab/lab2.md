# lab1_final.md

lab1 uses [Udemy TF on AZ - DevOps SRE 25 Demos ](https://www.udemy.com/course/terraform-on-azure-with-iac-azure-devops-sre-real-world-25-demos/learn/lecture/27976882#content)

It is unclear how far to go with lab1_final.   In discovery mode now.

**Side 148 is uesed for this section**

## Lab 1 final directions

- destroy everything
  - run `tf destroy --auto-approve `
  - check is RG exists  
    `az group list|grep name`

- copy lab1-starter  manefest to lab1-final

### Lab1 Final changes

- remove bastion
- make tf extension .norun rather then comment out.
- Change vms to ubuntu and sizes to 
  - CHANGE metadata
- Do rest of lab as is
  - Final goal are web listeners.  This may be done in later labs??
  - This is discovery mode, so these directions will changes
- Use "TUTURIAL:" to mark line that has TF link for TF tutorial. ie spat expressions
- Create tutorial that uses the above
  - use plan
  - use random w resource group
  - use tf console





#### Set CLI Authentication

See [ TF Cli logon](./https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli)

```
export ARM_SUBSCRIPTION_ID=$(az account show|jq .id|sed 's/"/'/g)
az account set --subscription=$ARM_SUBSCRIPTION_ID 

```
