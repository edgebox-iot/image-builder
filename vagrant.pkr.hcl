source "vagrant" "ubuntu-2204" {
  communicator = "ssh"
  source_path  = "bento/ubuntu-22.04"
  provider     = "virtualbox"
  add_force    = true
}

build {
  sources = ["source.vagrant.ubuntu-2204"]

  provisioner "ansible" {
    playbook_file = "./scripts/ansible/playbook.yml"
    ansible_ssh_extra_args = [
        "-o IdentitiesOnly=yes -o PubkeyAcceptedAlgorithms=+ssh-rsa -o HostkeyAlgorithms=+ssh-rsa"
    ]
  }
}
