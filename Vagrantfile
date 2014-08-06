# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # we use the latest debian version
  config.vm.box = "chef/debian-7.6"

  # set the hostname of the vm
  config.vm.hostname = "server.kolab3.dev"

  # execute shell script to install kolab
  config.vm.provision :shell, path: "bootstrap.sh"

  # forward the necessary ports
  config.vm.network "forwarded_port", guest: 80, host: 8080
end
