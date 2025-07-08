#Create a Null Resource and Provisioners

variable "ssh_key" {
  type        = string
  description = "ssh key to bastion"
  default     = "/home/david/.ssh/id_ed25519"
}

resource "null_resource" "null_copy_ssh_key_to_bastion" {
  depends_on = [azurerm_linux_virtual_machine.bastion_host_linuxvm]
  # Connection Block for Provisioners to connect to Azure VM Instance
  connection {
    type = "ssh"
    host = azurerm_linux_virtual_machine.bastion_host_linuxvm.public_ip_address
    user = azurerm_linux_virtual_machine.bastion_host_linuxvm.admin_username
    #private_key = file("${path.module}/ssh-keys/tf-web-server.pem")
    private_key = file(var.ssh_key)
  }
  ## File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    source      = "ssh-keys/tf_web_server.pem"
    destination = "/tmp/tf_web_server.pem"
  }
  ## Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 400 /tmp/tf-web-server.pem"
    ]
  }
}





# Creation Time Provisioners - By default they are created during resource creations (terraform apply)
# Destory Time Provisioners - Will be executed during "terraform destroy" command (when = destroy)# 
