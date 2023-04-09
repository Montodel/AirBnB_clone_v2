#!/usr/bin/env bash
#A Bash script that sets up my web servers for the deployment of web_static

#Install Nginx
sudo apt-get -y update
sudo apt-get -y install nginx

#Create folders
mkdir -p /data/web_static/releases/test/
mkdir -p /data/web_static/shared/

#create a fake HTNL file
echo "Holberton School for the win!" >/data/web_static/releases/test/index.html

#Create a symbolic link
sudo ln -sf "/data/web_static/releases/test" "/data/web_static/current"

#give ownership to ubuntu user And Group
sudo chown -R ubuntu:ubuntu "/data"

#Update the Nginx configuration to serve the content 
sudo sed -i "s/^.*location \/hbtn_static.*//" /etc/nginx/sites-available/default
sudo sed -i \
	"s/^}$/\tlocation \/hbtn_static \{ alias \/data\/web_static\/current\/; \}\n\}/" \
	/etc/nginx/sites-available/default

#enable default site
sudo ln -sf /etc/nginx/sites-available/default /etc/nginx/sites-enabled/default

#restart Ngnix server
sudo service nginx restart
