# PHASE 1 

Phase one readme

Phase one is built in steps.  
## See diagram.

## Step A

[Install Terraform](https://developer.hashicorp.com/terraform/install)
```
# update .bashrc
vi ~/.bashrc
set -o vi

# optional, but handles long directory paths well
export PS1='\u@\W: '

alias k=kubectl
alias tf=terraform
```


### Create step1 folder and files

The files from the 
[Terraform VM quickstart files](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-terraform?tabs=azure-cli)  have been copied to [initial_manifests folder](./i)



```
cd step1
cp -pr initial_manifests stage_manifests

```

```

````

