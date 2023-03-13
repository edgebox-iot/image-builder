# -*- mode: ruby -*-
# vi: set ft=ruby :

$bootstrap = <<-SCRIPT
apt-get update && apt-get install -y --no-install-recommends python3-pip
SCRIPT


Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-22.04"

  config.vm.synced_folder "bin/", "/tmp/edgebox"

  config.vm.provision "shell", inline: $bootstrap
  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "./scripts/ansible/playbook.yml"
  end
end
