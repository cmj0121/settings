SUBDIR = infra modules

.PHONY: all clean test plan apply output destroy help

all: 			# default action

clean:			# clean-up environment

test:			# run test

plan:			# plan the environment without applying

apply:			# apply the environment without asking

destroy:		# destroy the environment

help:			# show this message
	@printf "Usage: make [OPTION]\n"
	@printf "\n"
	@perl -nle 'print $$& if m{^[\w-]+:.*?#.*$$}' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?#"} {printf "    %-18s %s\n", $$1, $$2}'

plan apply output destroy: $(SUBDIR)

.PHONY: modules infra
modules: infra

$(SUBDIR):
	$(MAKE) -C $@ $(MAKECMDGOALS)
