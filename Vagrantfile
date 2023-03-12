# -*- mode: ruby -*-
# vi: set ft=ruby :

$bootstrap = <<-SCRIPT
apt-get update
apt-get -y install python3-pip
SCRIPT


Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-22.04"

  config.vm.synced_folder "bin/", "/tmp/"

  config.vm.provision "shell", inline: $bootstrap
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "./scripts/ansible/playbook.yml"
  end
end
