DST := ~/.bashrc ~/.profile
EXT := ~/.bash_aliases

.PHONY: all clean test run build upgrade help install

all: 			# default action

clean:			# clean-up environment
	@find . -name '*.sw[po]' -delete

test:			# run test

run:			# run in the local environment

build:			# build the binary/library

upgrade:		# upgrade all the necessary packages

help:			# show this message
	@printf "Usage: make [OPTION]\n"
	@printf "\n"
	@perl -nle 'print $$& if m{^[\w-]+:.*?#.*$$}' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?#"} {printf "    %-18s %s\n", $$1, $$2}'

install: $(DST) $(EXT)	# install neovim settings
	@echo you many need to type 'chsh -s /bin/bash'
	brew install bash-completion shellcheck

~/.bashrc: bashrc
	@mkdir -p $(shell dirname $@)
	install -m644 $< $@

~/.profile: bashrc
	@mkdir -p $(shell dirname $@)
	install -m644 $< $@

~/.bash_aliases: bash_aliases
	@mkdir -p $(shell dirname $@)
	install -m644 $< $@
