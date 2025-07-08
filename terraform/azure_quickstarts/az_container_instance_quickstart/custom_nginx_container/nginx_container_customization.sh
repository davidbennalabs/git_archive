############################################
#  IMPORTANT
###  just need to create /dev and prod dirctories

cat /etc/nginx/confif.d/default.conf

cd /usr/share/nginx/html

mkdir dev prod
cp devindex.htl dev/index.html
cp prodindex.htl prod/index.html







###########################################
docker pull ubuntu
docker run -d -p 8000:80 --name custom-ubuntu  ubuntu
docker run -it -d -p 8000:80 --name custom-ubuntu  ubuntu bash

apt update -y

# https://nginx.org/en/linux_packages.html#Ubuntu
apt install curl gnupg2 ca-certificates lsb-release ubuntu-keyring
###### Had to remove tee
#  curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null

curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor  >   /usr/share/keyrings/nginx-archive-keyring.gpg

gpg --dry-run --quiet --no-keyring --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg



echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
    | tee /etc/apt/sources.list.d/nginx.list

# optional Set up repository pinning to prefer our packages over distribution-provided ones:

echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
    | tee /etc/apt/preferences.d/99nginx

apt update -y
apt install nginx -y

apt install systemctl
systemctl start nginx
curl localhost

apt install vim


##############################