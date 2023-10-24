SUBDIR := playbooks terraform

.PHONY: all clean test run build destroy upgrade help

all: 			# default action

clean:			# clean-up the local homelab machine

test:			# run test

run:			# run in the local environment

build:			# build the local homelab machine

upgrade:		# upgrade all the necessary packages

help:			# show this message
	@printf "Usage: make [OPTION]\n"
	@printf "\n"
	@perl -nle 'print $$& if m{^[\w-]+:.*?#.*$$}' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?#"} {printf "    %-18s %s\n", $$1, $$2}'

$(SUBDIR):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: playbooks terraform
terraform: playbooks
all clean test run build destroy: $(SUBDIR)
