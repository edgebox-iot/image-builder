.DEFAULT_GOAL := virtualbox


setup:
	./scripts/make/local_setup.sh

digitalocean: setup
	packer init digitalocean.pkr.hcl
	packer build digitalocean.pkr.hcl

virtualbox: setup
	packer init virtualbox.pkr.hcl
	packer build virtualbox.pkr.hcl
		echo 'Built virtualbox'

all: virtualbox digitalocean
	echo 'Finished'

release: clean all

clean:
	rm -rf bin/*
	rm -rf output-*


