#!/usr/bin/env bash

apt-get update

# install docker
apt-get install -y docker.io

apt-get install -y apache2

if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi