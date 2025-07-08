# ISSUES

```
- could not access web server using public from bastion nor local   
  Did not try privat IP>
  Did not check security group setting.

Check Udemy Video and Hnadout to see how you are supposed to access.  I believe through LB

Also it looked like the public IP for VM was the same as one for LB...

# ssh to web from bastion using copied key
ssh -i  /tmp/tf-web-server.pem  10.1.100.4
Load key "/tmp/tf-web-server.pem": error in libcrypto
azureuser@10.1.100.4: Permission denied (publickey).

```