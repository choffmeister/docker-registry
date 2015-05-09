#!/bin/bash -e

# docker
wget -qO- https://get.docker.com/ | sh

sleep 5

# docker registry
mkdir -p /var/docker-registry/data
cp /vagrant/files/docker-registry/upstart.conf /etc/init/docker-registry.conf
docker pull registry:0.9.1
start docker-registry

sleep 5

# docker registry frontend
mkdir -p /var/docker-registry-frontend
cd /var/docker-registry-frontend
tar xfz /vagrant/files/docker-registry-frontend/a42b16c.tar.gz
echo '{"host": "localhost","port": 8080}' > /var/docker-registry-frontend/registry-host.json

sleep 5

# nginx
mkdir -p /var/nginx/conf.d
cp /vagrant/files/nginx/site.conf /var/nginx/conf.d/default.conf
cp /vagrant/files/nginx/upstart.conf /etc/init/nginx.conf
docker pull nginx:1.9.0
start nginx

exit 0
