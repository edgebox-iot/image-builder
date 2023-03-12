# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "bento/ubuntu-22.04"

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "./scripts/ansible/playbook.yml"
  end
end
