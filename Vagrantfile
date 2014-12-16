# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_NAME = ENV['BOX_NAME'] || "ubuntu"
BOX_URI = ENV['BOX_URI'] || "http://files.vagrantup.com/trusty64.box"
AWS_REGION = ENV['AWS_REGION'] || "ap-southeast2"
AWS_AMI    = ENV['AWS_AMI']
VAGRANTFILE_API_VERSION = "2"

Vagrant::Config.run do |config|
  config.vm.box = "ubuntu/trusty64"
  #config.vm.box = BOX_NAME
  #config.vm.box_url = BOX_URI
end

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ENV["AWS_ACCESS_KEY_ID"]
    aws.secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
    aws.keypair_name = ENV["AWS_KEYPAIR_NAME"]
    override.ssh.private_key_path = ENV["AWS_SSH_PRIVKEY"]
    override.ssh.username = "ubuntu"
    aws.region = AWS_REGION
    aws.ami    = AWS_AMI
    aws.instance_type = "m1.xlarge"
  end

  config.vm.provider :virtualbox do |vb|
    config.vm.hostname = "benji"
    config.vm.provision :shell, path: "bootstrap.sh"

    # port forwarding
    config.vm.network :forwarded_port, host: 8080, guest: 80

    # memory
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end
end
