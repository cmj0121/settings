DST := ~/.config/nvim/init.vim

.PHONY: all clean test run build upgrade help install

all: 			# default action

clean:			# clean-up environment

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
	git config --global user.name "cmj"
	git config --global user.email cmj@cmj.tw
	git config --global alias.co checkout
	git config --global alias.st status
	git config --global alias.br branch
	git config --global alias.la "log --graph --decorate --pretty=oneline --abbrev-commit --all"
