sudo apt-get install parcellite
sudo apt install acl # Used to change folder permissions

# Install beyond compare
wget https://www.scootersoftware.com/bcompare-4.2.9.23626_amd64.deb
sudo apt-get update
sudo apt-get install gdebi-core
sudo gdebi bcompare-4.2.9.23626_amd64.deb
# Uninstall
sudo apt-get remove bcompare

https://www.ostechnix.com/create-list-installed-packages-install-later-list-centos-ubuntu/

# PyCharm for python development
sudo snap install pycharm-community --classic
sudo snap install pycharm-professional --classic

# Resilio sync
# GOOD LINK ==> https://www.linuxbabe.com/ubuntu/install-resilio-sync-btsync-ubuntu-18-04-18-10
# (Secondary link: https://help.resilio.com/hc/en-us/articles/206178924-Installing-Sync-package-on-Linux)
wget http://linux-packages.resilio.com/resilio-sync/key.asc
sudo apt-key add key.asc
sudo apt install software-properties-common
sudo add-apt-repository "deb http://linux-packages.resilio.com/resilio-sync/deb resilio-sync non-free"
sudo apt update # Not needed on Ubuntu 18.4
sudo apt install resilio-sync
systemctl status resilio-sync
sudo systemctl start resilio-sync # Start it if not already started
sudo systemctl enable resilio-sync # Enable auto start at boot
# Webserver: 127.0.0.1:8888
# Set permissions correctly
sudo setfacl -R -m "u:rslsync:rwx" /home/saeed

# Install Nginx as a remote proxy
# Nginx becomes more and more popular these days as a web server and reverse proxy. 
sudo apt install nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo nano /etc/nginx/conf.d/resilio-sync.conf # create a virtual host file for Resilio Sync
# copy paste this into the file:
server {
  listen 80;
  server_name resilio.example.com;

  access_log /var/log/nginx/resilio_access.log;
  error_log /var/log/nginx/resilio_error.log;
  location / {
     proxy_pass http://127.0.0.1:8888;
     proxy_set_header Host $host;
     proxy_set_header X-Real-IP $remote_addr;
     proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
  }
}
sudo nginx -t # test configuration
sudo systemctl reload nginx # reload nginx if test passes

# For a similar reverse proxy az nginx, apache acn be used: see the link for resilio above

# Open Resilio Sync Port in Firewall
# see link resilio above

