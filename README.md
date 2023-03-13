# image-builder

Building ready to use images of Edgebox for various environments

*The configurations described in this repository depend on [HashiCorp's Packer tool](https://www.packer.io/). Refer to [Packer's documentation for installing it](https://learn.hashicorp.com/tutorials/packer/get-started-install-cli#installing-packer) on your platform.*

## Setup

1. run `make setup` to setup the required dependencies
2. Choose which image you want to build. Currently available images can be found in the `images` section below.
3. Create the `variables.auto.pkrvars.hcl` file and insert any necessary variables to build your images (See `image variables` below). The format is `key="value"`.

## Running

### With Packer CLI

- Run `packer build -only=[image] .` (or `packer build .` for all)

#### Images

The following images are currently supported, and can be built using the `packer build -only=[image] .` command:

- DigitalOcean (`digitalocean.ubuntu`)
- Vagrant (`vagrant.ubuntu-2204`)

### With Make

- Run `make [target]` (or `make all` for all)

#### Targets

The following targets are available:

- `all` - Builds all images
- `digitalocean` - Builds the DigitalOcean image
- `vagrant` - Builds the Vagrant image

## Image Variables

Depending on the image being built, it may require variables that need to be provided beforehand. Here's a list of variables per type of image supported:

- **All Images**
  - `edgebox_system_pw` - The default password for the system user.

- **DigitalOcean**
  - `digitalocean_api_token` - The API token that can [be obtained in your DigitalOcean account](https://docs.digitalocean.com/reference/api/create-personal-access-token/).


# Local tinkering 

Included as a vagrant stack to make testing the provisioning scripts easier.
