SUBDIR = based services

.PHONY: all clean test plan output build destroy help $(SUBDIR)

all: 			# default action

clean:			# clean-up environment

test:			# run test

plan:			# plan the environment without applying

build:			# apply the environment without asking
	$(MAKE) -C based $(MAKECMDGOALS)
	$(MAKE) -C services $(MAKECMDGOALS)

destroy:		# destroy the environment
	$(MAKE) -C services $(MAKECMDGOALS)
	$(MAKE) -C based $(MAKECMDGOALS)

help:			# show this message
	@printf "Usage: make [OPTION]\n"
	@printf "\n"
	@perl -nle 'print $$& if m{^[\w-]+:.*?#.*$$}' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?#"} {printf "    %-18s %s\n", $$1, $$2}'

all clean plan output: $(SUBDIR)

$(SUBDIR):
	$(MAKE) -C $@ $(MAKECMDGOALS)
