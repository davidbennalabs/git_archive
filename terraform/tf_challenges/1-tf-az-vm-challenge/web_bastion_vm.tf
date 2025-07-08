locals {
  bastion_custom_data = <<CUSTOM_DATA
#!/usr/bin/bash
echo "set -o vi" >> /home/azureuser/.bashrc
sudo apt update -y
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
CUSTOM_DATA
}

# locals {

# }
data "azurerm_role_definition" "contributor" {
  name = "Contributor"
}

resource "azurerm_role_assignment" "example" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_linux_virtual_machine.my_terraform_vm.identity[0].principal_id
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "my_terraform_vm" {
  #count                 = 1
  name                  = "${var.project}-vm-1"
  computer_name         = "${var.project}-vm-1"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = var.vm_size
  admin_username        = var.username
  network_interface_ids = [azurerm_network_interface.my_terraform_nic.id]
  identity {
    type = "SystemAssigned"
  }
  #   admin_password        = var.admin_password
  #   disable_password_authentication = false
  admin_ssh_key {
    # username = var.username
    username = "azureuser"
    #public_key = file("${path.module}/ssh-keys/id_ed25519.pub")
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  # adds system assigned identity

  #custom_data = filebase64("${path.module}/app-scripts/redhat-webvm-script.sh")    
  custom_data = base64encode(local.bastion_custom_data)

  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.my_storage_account.primary_blob_endpoint
  }
}

