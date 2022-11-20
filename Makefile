setup:
	./scripts/make/local_setup.sh

digitalocean:
	./scripts/make/digitalocean_setup.sh

virtualbox:
	./scripts/make/virtualbox_setup.sh

vagrant:
	./scripts/make/vagrant_setup.sh

all:
	./scripts/make/all_setup.sh

clean:
	./scripts/make/clean.sh