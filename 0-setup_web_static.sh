#!/usr/bin/env bash

# sets up your web servers for the deployment of web_static

#Install Nginx
sudo apt-get -y update
sudo apt-get -y install nginx

#Create folders
sudo mkdir -p /data/ /data/web_static/ /data/web_static/releases/ /data/web_static/shared/ /data/web_static/releases/test/

#create a fake HTNL file
echo "Holberton School for the win!" | sudo tee /data/web_static/releases/test/index.html > /dev/null

#removing the file to modify it
sudo rm -rf /data/web_static/current

#Create a symbolic link
sudo ln -s /data/web_static/releases/test/ /data/web_static/current

#give ownership to ubuntu user And Group
sudo chown -R ubuntu:ubuntu /data/

#Update the Nginx configuration to serve the content
NEW_STRING="\\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n"
sudo sed -i "38i $NEW_STRING" /etc/nginx/sites-available/default

#restart Ngnix server
sudo service nginx restart
