#!/usr/bin/bash
sudo apt update -y
# install kubeclt
 curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
 sudo cp kubectl /usr/bin
# install terraform
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
# install az cli
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
sudo cp kubectl /usr/bin/
sudo chmod 755 /usr/bin/kubectl 


# install docker

# update or copy .bashrc