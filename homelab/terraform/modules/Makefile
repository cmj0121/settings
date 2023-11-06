SUBDIR = based storage monitoring hosting

.PHONY: all clean test plan output output-json build destroy help

all: 			# default action

clean:			# clean-up environment

test:			# run test

plan:			# plan the environment without applying

build:			# apply the environment without asking

destroy:		# destroy the environment
	$(MAKE) -C monitoring $(MAKECMDGOALS)
	$(MAKE) -C storage    $(MAKECMDGOALS)
	$(MAKE) -C based      $(MAKECMDGOALS)

help:			# show this message
	@printf "Usage: make [OPTION]\n"
	@printf "\n"
	@perl -nle 'print $$& if m{^[\w-]+:.*?#.*$$}' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?#"} {printf "    %-18s %s\n", $$1, $$2}'

all clean build plan output output-json: $(SUBDIR)

$(SUBDIR):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: based storage monitoring hosting
storage: based
monitoring hosting: storage
