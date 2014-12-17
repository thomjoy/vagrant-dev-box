# -*- mode: ruby -*-
# vi: set ft=ruby :

AWS_REGION = ENV['AWS_REGION'] || "ap-southeast2"
AWS_AMI    = ENV['AWS_AMI']

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"

  # disable the /vagrant synced folder
  config.vm.synced_folder '.', '/vagrant', disabled: true

  #network
  config.vm.network :private_network, ip: "192.168.33.10"

  # port forwarding
  config.vm.network :forwarded_port, host: 8080, guest: 80

  #virtualbox
  if defined? VagrantVbguest
    config.vbguest.auto_update = true
  end

  #shared
  config.vm.synced_folder "~/code", "/code"

  # provisioning
  config.vm.hostname = "benji"
  config.vm.provision :shell, path: "provision/setup.sh"

  # aws
  #config.vm.provider :aws do |aws, override|
  #  aws.access_key_id = ENV["AWS_ACCESS_KEY_ID"]
  #  aws.secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
  #  aws.keypair_name = ENV["AWS_KEYPAIR_NAME"]
  #  override.ssh.private_key_path = ENV["AWS_SSH_PRIVKEY"]
  #  override.ssh.username = "ubuntu"
  #  aws.region = AWS_REGION
  #  aws.ami    = AWS_AMI
  #  aws.instance_type = "m1.xlarge"
  #end

  # virtualbox
  config.vm.provider :virtualbox do |vb|
    # memory
    vb.customize ["modifyvm", :id, "--name", "benji" , "--memory", "2048"]

    # nat
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
end
