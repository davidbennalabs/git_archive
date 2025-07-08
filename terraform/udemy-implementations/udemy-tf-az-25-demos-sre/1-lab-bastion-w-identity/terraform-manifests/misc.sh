export myVM=hr-dev-web-linuxvm
export myResourceGroup=hr-dev-rg-lccyec
az vm extension set --resource-group $myResourceGroup --vm-name $myVM --name WindowsOpenSSH --publisher Microsoft.Azure.OpenSSH --version 3.0

az network nsg rule create -g $myResourceGroup --nsg-name $myNSG -n allow-SSH --priority 1000 --source-address-prefixes 208.130.28.4/32 --destination-port-ranges 22 --protocol TCP


az vm run-command invoke -g $myResourceGroup -n $myVM --command-id RunPowerShellScript --scripts "MYPUBLICKEY | Add-Content 'C:\ProgramData\ssh\administrators_authorized_keys' -Encoding UTF8;icacls.exe 'C:\ProgramData\ssh\administrators_authorized_keys' /inheritance:r /grant 'Administrators:F' /grant 'SYSTEM:F'"

export myVM=hr-dev-web-linuxvm
export myResourceGroup=hr-dev-rg-lccyec
export myUsername=azureuser
az ssh vm  -g $myResourceGroup -n $myVM --local-user $myUsername