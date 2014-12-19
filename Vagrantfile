# -*- mode: ruby -*-
# vi: set ft=ruby :

AWS_REGION = ENV['AWS_REGION'] || "ap-southeast2"
AWS_AMI    = ENV['AWS_AMI']

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"

  # disable the /vagrant synced folder
  config.vm.synced_folder '.', '/vagrant', disabled: true

  # set up /var/www
  config.vm.synced_folder 'www/', '/var/www'

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
  #config.vm.provision :shell, path: "provision/shell/setup.sh"

  config.vm.provision :puppet do |puppet|
     puppet.facter          = { "fqdn" => "local.benji", "hostname" => "benji" }
     puppet.manifests_path  = "provision/puppet/manifests"
     puppet.manifest_file   = "provision/puppet/base.pp"
     puppet.module_path     = "provision/puppet/modules"
  end

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
    vb.customize [
      "modifyvm", :id,
      "--name", "benji",
      "--memory", "2048",
      "--natdnshostresolver1", "on",
      "--cpus", "2",
      "--ioapic", "on"
      ]
  end

  # linode
  config.vm.provider :linode do |provider, override|
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    override.vm.box = 'linode'
    override.vm.box_url = "https://github.com/displague/vagrant-linode/raw/master/box/linode.box"

    provider.token = 'API_KEY'
    provider.distribution = 'Ubuntu 14.04 LTS'
    provider.datacenter = 'tokyo'
    provider.plan = 'Linode 1024'
    # provider.planid = <int>
    # provider.paymentterm = <*1*,12,24>
    # provider.datacenterid = <int>
    # provider.image = <string>
    # provider.imageid = <int>
    # provider.private_networking = <boolean>
    # provider.stackscript = <string>
    # provider.stackscriptid = <int>
    # provider.distributionid = <int>
  end
end
