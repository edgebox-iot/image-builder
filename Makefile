.DEFAULT_GOAL := vagrant

setup:
	./scripts/make/local_setup.sh

digitalocean: setup
	packer init digitalocean.pkr.hcl
	packer build digitalocean.pkr.hcl

vagrant: setup
	packer init vagrant.pkr.hcl
	packer build vagrant.pkr.hcl
	echo 'Built vagrant'

all: vagrant digitalocean
	echo 'Finished'

release: clean all

clean:
	rm -rf bin/*
	rm -rf output-*
