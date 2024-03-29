packer {
  required_plugins {
    digitalocean = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/digitalocean"
    }
  }
}

source "digitalocean" "ubuntu" {
  api_token     = "${var.digitalocean_api_token}"
  image         = "ubuntu-20-04-x64"
  region        = "fra1"
  size          = "s-1vcpu-1gb"
  ssh_username  = "root"
  ssh_password  = "demo"
  snapshot_name = "edgebox-cloud-001-{{timestamp}}"
}

build {
  sources = [
    "source.digitalocean.ubuntu",
  ]

  provisioner "file" {
    source      = "./bin/"
    destination = "/tmp"
  }

  provisioner "shell" {
    environment_vars = [
      "SYSTEM_PW=${var.edgebox_system_pw}"
    ]
    scripts = [
      "scripts/packer/setup_base.sh",
    ]
  }
}
