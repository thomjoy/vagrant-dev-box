#!/usr/bin/env bash

apt-get update

INSTALL="sudo apt-get install -y"

# native addons
$INSTALL build-essential

# locale
$INSTALL language-pack-en

# install docker
$INSTALL docker.io

# install apache
$INSTALL apache2

# install nginx
$INSTALL nginx

# install node
curl -sL https://deb.nodesource.com/setup | sudo sh -
$INSTALL nodejs

# install postgres + postgis
$INSTALL postgresql postgis

# install java
sudo apt-add-repository -y ppa:webupd8team/java
sudo apt-get update
$INSTALL oracle-java8-installer

# auto accept the java licence terms
sudo echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

# install rabbitmq
$INSTALL rabbitmq-server

# install scala

# install zsh
$INSTALL zsh

# om zsh + dotfiles
cd /home/vagrant && wget --no-check-certificate https://raw.githubusercontent.com/thomjoy/dotfiles/master/.zshrc
wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
chsh -s /bin/zsh vagrant
source /home/vagrant/.zshrc

# project specific
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi