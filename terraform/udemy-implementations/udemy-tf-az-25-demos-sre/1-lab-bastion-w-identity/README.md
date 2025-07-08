## README.md 

# Set CLI Authentication

See [ Tf cli logon](./https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/azure_cli)

```
export ARM_SUBSCRIPTION_ID=$(az account show|jq .id|sed 's/"/'/g)
az account set --subscription=$ARM_SUBSCRIPTION_ID 

tf plan -out tfplane
tf apply tfplan

```

### Checks

All checks using console (so you can learn console and it is easier to demo results w gui)

- Check network security group restriced to "myip"

```
- Check ss access
  - ssh to bastion
    ssh -i /home/david/.ssh/id_ed25519 azureuser@52.224.7.107
    curl localhost
  - ssh bastion to web
  - ssh lap to to web through lb  USING PORT 1022

  ssh -i ~/.ssh/tf-web-server azureuser@172.191.241.97

- check init scripts on bastion and web

```

### CHANGES

- Add MYIP as a clitfvar.  It is now in tfvars
- add nginx to redhat instance
- FIX/Extend ngins on bastion.


New release '24.04.2 LTS' available.
Run 'do-release-upgrade' to upgrade to it.