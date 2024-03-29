.DEFAULT_GOAL := vagrant

setup:
	./scripts/make/local_setup.sh

format: 
	packer fmt .

digitalocean: setup
	packer init digitalocean.pkr.hcl
	packer build -only=digitalocean.ubuntu .

vagrant: setup
	packer init vagrant.pkr.hcl
	packer build vagrant.pkr.hcl

all: vagrant digitalocean


release: clean all

clean:
	rm -rf bin/*
	rm -rf output-*
