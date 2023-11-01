HOMELAB := homelab

.PHONY: all clean test run build destroy upgrade help

all: 			# default action

clean:			# clean-up environment

test:			# run test

run:			# run in the local environment

build: apply	# build the local homelab machine

destroy:		# destroy the environment
	@if multipass info $(HOMELAB) >/dev/null; then \
		multipass delete $(HOMELAB) --purge; \
	fi

upgrade:		# upgrade all the necessary packages

help:			# show this message
	@printf "Usage: make [OPTION]\n"
	@printf "\n"
	@perl -nle 'print $$& if m{^[\w-]+:.*?#.*$$}' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?#"} {printf "    %-18s %s\n", $$1, $$2}'

launch:
	@if ! multipass info $(HOMELAB) >/dev/null; then \
		multipass launch --name $(HOMELAB) --memory 8G --disk 20G --cpus 4; \
	fi
	cat "$(HOME)/.ssh/id_ed25519.pub" | multipass exec "$(HOMELAB)" -- bash -c "cat >> ~/.ssh/authorized_keys"
	multipass info $(HOMELAB)

apply: launch
	ansible-playbook main.yml \
		-e ansible_user=ubuntu \
		-i "$(shell multipass info $(HOMELAB) --format json | jq .info.$(HOMELAB).ipv4[0] -r),"
