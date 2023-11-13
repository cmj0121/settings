SUBDIR = infra modules

.PHONY: all clean test plan output output-json build destroy help $(SUBDIR)

all: 			# default action

clean:			# clean-up environment

test:			# run test

plan:			# plan the environment without applying

build:			# apply the environment without asking
	$(MAKE) -C infra $(MAKECMDGOALS)
	$(MAKE) -C modules $(MAKECMDGOALS)

destroy:		# destroy the environment
	$(MAKE) -C modules $(MAKECMDGOALS)
	$(MAKE) -C infra $(MAKECMDGOALS)

help:			# show this message
	@printf "Usage: make [OPTION]\n"
	@printf "\n"
	@perl -nle 'print $$& if m{^[\w-]+:.*?#.*$$}' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?#"} {printf "    %-18s %s\n", $$1, $$2}'

all clean plan output output-json: $(SUBDIR)

$(SUBDIR):
	$(MAKE) -C $@ $(MAKECMDGOALS)
