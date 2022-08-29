# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.network "private_network", ip: "192.168.100.218"
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true
  config.vm.hostname = "pintos"
  config.vm.provision :shell, path: "bootstrap.sh"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = 2048
  end
end
