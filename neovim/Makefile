DST := ~/.config/nvim/init.vim ~/.local/share/nvim/site/autoload/plug.vim

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

install: $(DST)		# install neovim settings
	brew install nvim actionlint diagnostics checkmake commitlint flake8 hadolint mypy
	npm install write-good --global

~/.config/nvim/init.vim: init.vim
	@mkdir -p $(shell dirname $@)
	install -m644 $< $@

~/.local/share/nvim/site/autoload/plug.vim:
	curl -fLo $@ --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
