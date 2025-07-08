# Locals Block for custom data
locals {
  webvm_custom_data = <<CUSTOM_DATA
#!/usr/bin/bash
echo "set -o vi" >> /home/azureuser/.bashrc
sudo apt update -y
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo cp kubectl /usr/bin
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
sudo cp kubectl /usr/bin/
sudo chmod 755 /usr/bin/kubectl 
sudo apt install nginx -y
sudo systemctl enable nginx
sudo systemctl start nginx
sudo mkdir -p /usr/share/nginx/html/app1
sudo curl -H "Metadata:true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" -o /usr/share/nginx/html/app1/metadata.html 
CUSTOM_DATA
}

## using splat expression vs for loop 
## TUTORIAL: https://developer.hashicorp.com/terraform/language/expressions/splat
# Resource: Azure Linux Virtual Machine
resource "azurerm_linux_virtual_machine" "web_linuxvm" {
  count = var.web_linuxvm_instance_count
  name  = "${local.resource_name_prefix}-web-linuxvm-${count.index}"
  #computer_name = "web-linux-vm"  # Hostname of the VM (Optional)
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  #size                  = "Standard_DS1_v2"
  size           = var.web_vm_size #"Standard_B1s"
  admin_username = "azureuser"
  #network_interface_ids = [azurerm_network_interface.web_linuxvm_nic.id]
  network_interface_ids = [element(azurerm_network_interface.web_linuxvm_nic[*].id, count.index)]
  admin_ssh_key {
    username = "azureuser"
    # modified
    public_key = file("${path.module}/ssh-keys/tf-web-server.pub")
  }
  #   admin_ssh_key {
  #     username   = "azureuser"
  #     public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  #   }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "83-gen2"
    version   = "latest"
  }
  #custom_data = filebase64("${path.module}/app-scripts/redhat-webvm-script.sh")    
  custom_data = base64encode(local.webvm_custom_data)

}
