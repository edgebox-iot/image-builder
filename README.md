# image-builder

Building ready to use images of Edgebox for various environments

*The configurations described in this repository depend on [HashiCorp's Packer tool](https://www.packer.io/). Refer to [Packer's documentation for installing it](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli#installing-packer) on your platform.*

## Setup

1. run `make setup` to setup the required dependencies
3. Choose which image you want to build. Currently available:
   - DigitalOcean (`digitalocean.ubuntu`) 
   - _TODO:_ VirtualBox (`virtualbox`)
4. Create the `variables.auto.pkrvars.hcl` file and insert any necessary variables to build your images (See `image variables ` below). The format is `key="value"`.
5. Run `packer build -only=[image] .` (or `packer build .` for all)

## Image Variables

Depending on the image being built, it may require variables that need to be provided beforehand. Here's a list of variables per type of image supported:
- **All Images**
  - `edgebox_system_pw` - The default password for the system user.

- **DigitalOcean**
  - `digitalocean_api_token` - The API token that can [be obtained in your DigitalOcean account](https://docs.digitalocean.com/reference/api/create-personal-access-token/).
