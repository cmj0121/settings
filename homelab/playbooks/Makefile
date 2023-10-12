HOMELAB := homelab

.PHONY: all clean test run build upgrade help

all: 			# default action

clean:			# clean-up environment
	multipass delete $(MACHINE) --purge

test:			# run test

run:			# run in the local environment
	ansible-playbook -i inventory.ini main.yml

build:			# build the local homelab machine
	multipass launch --name $(HOMELAB) --mem 8G --disk 4G --cpus 4
	cat "$(HOME)/.ssh/id_ed25519.pub" | multipass exec "$(HOMELAB)" -- bash -c "cat >> ~/.ssh/authorized_keys"
	multipass info $(HOMELAB)

upgrade:		# upgrade all the necessary packages

help:			# show this message
	@printf "Usage: make [OPTION]\n"
	@printf "\n"
	@perl -nle 'print $$& if m{^[\w-]+:.*?#.*$$}' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?#"} {printf "    %-18s %s\n", $$1, $$2}'
