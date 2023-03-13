source "vagrant" "ubuntu-2204" {
  communicator = "ssh"
  source_path  = "bento/ubuntu-22.04"
  provider     = "virtualbox"
  add_force    = true
}

build {
  sources = ["source.vagrant.ubuntu-2204"]

  provisioner "file" {
    source = "scripts/ansible/requirements.yml"
    destination = "/tmp/requirements.yml"
  }

  provisioner "shell" {
      inline = ["sudo apt-get update && sudo apt-get upgrade && sudo apt-get -y install python3-pip ansible && ansible-galaxy install -r /tmp/requirements.yml"]
  }

  provisioner "file" {
    source      = "bin/"
    destination = "/tmp"
  }

  provisioner "ansible-local" {
    playbook_file = "./scripts/ansible/playbook.yml"
  }
}
