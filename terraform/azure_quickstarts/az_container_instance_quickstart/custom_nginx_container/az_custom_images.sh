
# https://learn.microsoft.com/en-us/azure/container-registry/container-registry-get-started-docker-cli?tabs=azure-cli

az login
#export rg=DaveContainerCLIRg
# using tf existing rg
export rg=rg-simple-lioness
export acr=davecontainerrepo

# az acr create --resource-group $RG --name "${rg}" --sku Standard --role-assignment-mode 'rbac-abac' --dnl-scope TenantReuse

# default is standard.  Basic is cheapest
az acr create -n $acr -g $rg --sku Basic #

az acr login --name $acr




