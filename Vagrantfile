# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # we use the latest debian version
  config.vm.box = "chef/debian-7.6"

  # set the hostname of the vm
  config.vm.hostname = "server.kolab3.dev"

  # first install puppet in vm
  config.vm.provision "shell", inline: "apt-get -y install puppet"
  # second run puppet to get kolab into it
  config.vm.provision "puppet" do |puppet|
    puppet.module_path = "modules"
  end

  # forward the necessary ports
  config.vm.network "forwarded_port", guest: 80, host: 8080
end
