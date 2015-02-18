# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define "debian-wheezy" do |vmconfig|
    # we use the latest debian version
    vmconfig.vm.box = "chef/debian-7.8"

    # set the hostname of the vm
    vmconfig.vm.hostname = "debian-wheezy.kolab3.dev"

    # first install puppet in vm
    vmconfig.vm.provision "shell", inline: "apt-get -y install puppet"
    # second run puppet to get kolab into it
    vmconfig.vm.provision "puppet" do |puppet|
      puppet.module_path = "modules"
    end

    # forward the necessary ports
    vmconfig.vm.network "forwarded_port", guest: 25, host: 1025, auto_correct: true
    vmconfig.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
    vmconfig.vm.network "forwarded_port", guest: 110, host: 10110, auto_correct: true
    vmconfig.vm.network "forwarded_port", guest: 143, host: 10143, auto_correct: true
    vmconfig.vm.network "forwarded_port", guest: 443, host: 10443, auto_correct: true
    vmconfig.vm.network "forwarded_port", guest: 587, host: 10587, auto_correct: true
    vmconfig.vm.network "forwarded_port", guest: 993, host: 10993, auto_correct: true
    vmconfig.vm.network "forwarded_port", guest: 995, host: 10995, auto_correct: true
  end

  config.vm.define "ubuntu-trusty" do |vmconfig|
    # we use the latest debian version
    vmconfig.vm.box = "ubuntu/trusty64"

    # set the hostname of the vm
    vmconfig.vm.hostname = "ubuntu-trusty.kolab3.dev"

    # first install puppet in vm
    vmconfig.vm.provision "shell", inline: "apt-get -y install puppet"
    # second run puppet to get kolab into it
    vmconfig.vm.provision "puppet" do |puppet|
      puppet.module_path = "modules"
    end

    # forward the necessary ports
    vmconfig.vm.network "forwarded_port", guest: 25, host: 1025, auto_correct: true
    vmconfig.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
    vmconfig.vm.network "forwarded_port", guest: 110, host: 10110, auto_correct: true
    vmconfig.vm.network "forwarded_port", guest: 143, host: 10143, auto_correct: true
    vmconfig.vm.network "forwarded_port", guest: 443, host: 10443, auto_correct: true
    vmconfig.vm.network "forwarded_port", guest: 587, host: 10587, auto_correct: true
    vmconfig.vm.network "forwarded_port", guest: 993, host: 10993, auto_correct: true
    vmconfig.vm.network "forwarded_port", guest: 995, host: 10995, auto_correct: true
  end

end
