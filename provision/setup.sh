#!/usr/bin/env bash

apt-get update

INSTALL="sudo apt-get install -y"

# locale
$INSTALL language-pack-en

# install docker
$INSTALL docker.io

# install apache
$INSTALL apache2

# install node
$INSTALL nodejs

# install postgres + postgis
$INSTALL postgresql postgis

# install java
sudo apt-add-repository -y ppa:webupd8team/java
sudo apt-get update
$INSTALL oracle-java8-installer

# auto accept the java licence terms
sudo echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections

# install scala

# install ohmyszh
$INSTALL zsh
wget --no-check-certificate https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
sudo chsh -s /bin/zsh vagrant
touch ~/.zshrc
zsh

# install dotfiles

# project specific
if ! [ -L /var/www ]; then
  rm -rf /var/www
  ln -fs /vagrant /var/www
fi