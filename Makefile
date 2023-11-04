SUBDIR := playbooks

.PHONY: all clean test install install-tag upgrade help $(SUBDIR)

all: 		 		# default action
	@[ -f .git/hooks/pre-commit ] || pre-commit install --install-hooks
	@git config commit.template .git-commit-template

clean: 				# clean-up environment
	@find . -name '*.sw[po]' -delete

test:				# run all tests

install:			# install the local DEV environment

install-tag:		# install the package with tags

upgrade:			# upgrade all the necessary packages
	pre-commit autoupdate

help:				# show this message
	@printf "Usage: make [OPTION]\n"
	@printf "\n"
	@perl -nle 'print $$& if m{^[\w-]+:.*?#.*$$}' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?#"} {printf "    %-18s %s\n", $$1, $$2}'

all clean install install-tags: $(SUBDIR)

$(SUBDIR):
	$(MAKE) -C $@ $(MAKECMDGOALS)

.PHONY: bootstrap
install install-tags $(SUBDIR): bootstrap
bootstrap:
	./$@
