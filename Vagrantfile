# -*- mode: ruby -*-
# vi: set ft=ruby :

AWS_REGION = ENV['AWS_REGION'] || "ap-southeast2"
AWS_AMI    = ENV['AWS_AMI']

VAGRANTFILE_API_VERSION = "2"

hostname = %x[ hostname -f ]
username = %x[ whoami ]

# might want to set this manually.
project  = File.basename(File.dirname(__FILE__));

puts "PROJECT = " + project

# Start configuring the box
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "ubuntu/trusty64"

  #network
  config.vm.network :private_network, ip: "192.168.33.10"

  # port forwarding
  config.vm.network :forwarded_port, host: 8080, guest: 80

  #virtualbox
  if defined? VagrantVbguest
    config.vbguest.auto_update = true
  end

  # Set up shared folders.
  # In real projects this would be probably be set to a folder outside of the vagrant folder
  # i.e.
  #  |-- vagrant
  #      |-- provision
  #      |-- VagrantFile
  #  |-- project_name
  #      |-- src (sync this as "../src")
  config.vm.synced_folder "app", "/vagrant/app"

  # Forward SSH key agent over the 'vagrant ssh' connection
  config.ssh.forward_agent = true

  # Set the hostname
  #config.vm.hostname = "web.%s.%s" % [ project, hostname.strip.to_s ]
  config.vm.hostname = project

  puts "HOSTNAME: %s %s" % [ project, hostname.strip.to_s ]

  # Bootstrap puppet + ruby on the box
  config.vm.provision :shell, path: "provision/shell/puppet-bootstrap.sh"

  config.vm.provision :puppet do |puppet|
      puppet.facter = {
        "vagrant" => "1",
        "vagrant_ssh_user" => username.strip.to_s,
      }
      puppet.manifests_path   = "provision/puppet/manifests"
      puppet.manifest_file    = "site.pp"
      puppet.module_path      = "provision/puppet/modules"
      puppet.options          = "--hiera_config /server/vagrant/hiera.yaml"

      # Send "notice" to syslog
      #puppet.options += " --logdest syslog"

      # Enable this to see the details of a puppet run
      puppet.options += " --verbose --debug"
  end

  # Virtualbox
  config.vm.provider :virtualbox do |vbox|
    vbox.customize [
      "modifyvm", :id,
      "--name", "benji",
      "--memory", "2048",
      "--cpus", "2",
      "--ioapic", "on",
    ]

    # Use VirtualBox's builtin DNS proxy to avoid DNS issues when the
    # host has a DNS proxy (such as Ubuntu).
    # See: https://www.virtualbox.org/ticket/10864
    vbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]

    # Fix symlinks on Mac OSX
    # see: https://github.com/mitchellh/vagrant/issues/713
    vbox.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/v-root", "1"]
    vbox.customize ["setextradata", :id, "VBoxInternal2/SharedFoldersEnableSymlinksCreate/server", "1"]
  end

  # Linode
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
