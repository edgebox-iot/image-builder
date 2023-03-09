.DEFAULT_GOAL := vagrant

setup:
	./scripts/make/local_setup.sh
	ansible-galaxy install -r scripts/ansible/requirements.yml

format: 
	packer fmt .

digitalocean: setup
	packer init digitalocean.pkr.hcl
	packer build digitalocean.pkr.hcl

vagrant: setup
	packer init vagrant.pkr.hcl
	packer build vagrant.pkr.hcl

all: vagrant digitalocean


release: clean all

clean:
	rm -rf bin/*
	rm -rf output-*
