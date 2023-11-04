.PHONY: all clean test install install-tag upgrade help

all: 			# default action

clean:			# clean-up environment

test:			# run test

run:			# run in the local environment

install:			# install the local DEV environment
	@ansible-galaxy collection install community.general
	ansible-playbook -i inventory.ini main.yml

install-tag:		# install the package with tags
	ansible-playbook -i inventory.ini main.yml --tags $(TAG)

upgrade:		# upgrade all the necessary packages

help:			# show this message
	@printf "Usage: make [OPTION]\n"
	@printf "\n"
	@perl -nle 'print $$& if m{^[\w-]+:.*?#.*$$}' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?#"} {printf "    %-18s %s\n", $$1, $$2}'
