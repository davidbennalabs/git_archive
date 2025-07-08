https://learn.microsoft.com/en-us/azure/container-instances/container-instances-tutorial-prepare-app


1. create container image
   CHanges:
   - Add /dev and /prod to the node app
2. Create container registry
3. Deploy Application


### Create Container Image

# We are using the custon node.js image they created. 
# we will create it with our nginx image al

git clone https://github.com/Azure-Samples/aci-helloworld.git

# I added /dev and /prod to the node app
docker build ./aci-helloworld -t aci-tutorial-app

docker images

# MODIFY and add name
#docker run -d -p 8080:80 aci-tutorial-app
docker run -d -p 8080:80 --name dave_custom_node aci-tutorial-app 

docker exec -it  dave_custom_node sh

2. Create container registry

# I HAD TO use sudo from david account.  Probably setting in home? 
export acr="mynode"
export rg="david_container_lab_rg"
export acr_server="mynode.azurecr.io"

az group create --name $rg --location eastus
az acr create --resource-group $rg --name $acr --sku Basic
az acr login --name $acr
az acr show --name $acr --query loginServer --output table

az acr repository list --name $acr 
az acr repository show-tags --name $acr --repository aci-tutorial-app --output table

#export acr_server=$(az acr show --name $acr --query loginServer)
sudo docker tag aci-tutorial-app $acr_server/aci-tutorial-app:v1
sudo docker images
sudo docker push $acr_server/aci-tutorial-app:v1


## DEPLOY CONTAINERS
export acrName=$acr
az acr show --name $acrName --query loginServer

az container create --resource-group myResourceGroup --name aci-tutorial-app \
  --image <acrLoginServer>/aci-tutorial-app:v1 --cpu 1 --memory 1 \ 
  --registry-login-server <acrLoginServer> \
  --registry-username <service-principal-ID> \
  --registry-password <service-principal-password> \
  --ip-address Public --dns-name-label <aciDnsLabel> --ports 80




### SECOND
#export acr="davidacihelloworldnode"
# export acr_sever="davidnode-a5a6bkejaeaaf7bt.azurecr.io"
# export acr="davidnode"

export rg="david_container_lab_rg"


##### I HAD TO MANUALLY CREATE ACR name davidnode-a5a6bkejaeaaf7bt.azurecr.io
#### davidnode with DNS suffix for security
az group create --name $rg --location eastus
az acr create --resource-group $rg --name $acr --sku Basic
az acr login --name $acr
az acr show --name $acr --query loginServer --output table

# check aci-tutorial-app
docker tag aci-tutorial-app $acr_sever/aci-tutorial-app:v1
docker images
docker push davidnode-a5a6bkejaeaaf7bt.azurecr.io/aci-tutorial-app:v1

#docker push davidnode-a5a6bkejaeaaf7bt.azurecr.io/aci-tutorial-app:v1

docker push $acr_sever/aci-tutorial-app:v1
az ad user show --id "drb@davidbennalabsoutlook.onmicrosoft.com" --query "id" --output tsv


###################  LOGIN ERROR #############
az ad user list


## Error stated need helm
https://helm.sh/docs/intro/install/
wget https://get.helm.sh/helm-v3.18.3-linux-amd64.tar.gz






#### OTHER IMAGES
docker run -d -p 8100:80 -it --name custom-nginx nginx
docker ps
docker exec -it custom-nginx bash

docker pull ubuntu
docker run -d -p 8000:80 --name custom-ubuntu  ubuntu
docker run -it -d -p 8000:80 --name custom-ubuntu  ubuntu bash

apt update -y