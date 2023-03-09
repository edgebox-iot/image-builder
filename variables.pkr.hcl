variable "digitalocean_api_token" {
  type    = string
  default = "your_token_here"
  // Sensitive vars are hidden from output as of Packer v1.6.5
  sensitive = true
}

variable "edgebox_system_pw" {
  type    = string
  default = "demo"
  // Sensitive vars are hidden from output as of Packer v1.6.5
  sensitive = true
}

