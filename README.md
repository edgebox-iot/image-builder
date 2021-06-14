# cloud-image-builder

Building ready to use images of Edgebox for Cloud Environments

*The configurations described in this repository depend on [HashiCorp's Packer tool](https://www.packer.io/). Refer to [Packer's documentation for installing it](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli#installing-packer) on your platform.*

## Setup

1. Download the latest releases of:
   - [`edgebox-iot/edgeboxctl`](https://github.com/edgebox-iot/edgeboxctl/releases/latest)
   - [`edgebox-iot/ws`](https://github.com/edgebox-iot/ws/releases/latest)
   - [`edgebox-iot/api`](https://github.com/edgebox-iot/api/releases/latest)
   - [`edgebox-iot/apps`](https://github.com/edgebox-iot/apps/releases/latest)
2. Copy each one to the `bin` folder of this project (it is git ignored).
3. Choose which image you want to build. Currently available:
   - DigitalOcean (`digitalocean`) 
   - _TODO:_ VirtualBox (`virtualbox`)
4. Create the `variables.auto.pkr.hcl` file and insert any necessary variables to build your images (See `image variables ` below). An example file is included (`variables.auto.pkr.hcl.example`).
5. Run `packer build [image_name].pkr.hcl`

## Image Variables

Depending on the image being built, it may require variables that need to be provided beforehand. Here's a list of variables per type of image supported:
- **All Images**
  - `edgebox-system_pw` - The default password for the system user.

- **DigitalOcean**
  - `digitalocean-api_token` - The API token that can [be obtained in your DigitalOcean account](https://docs.digitalocean.com/reference/api/create-personal-access-token/).