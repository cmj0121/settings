#! /usr/bin/env bash

# some more ls aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='vim -p'
alias ll='ls -al'
alias la='ls -A'

# customized alias for Darwin
if [ "$(uname)" = Darwin ] || [ "$TERM_PROGRAM" = Apple_Terminal ]; then
	alias ls='ls -w'
fi

# vim: ft=bash:
