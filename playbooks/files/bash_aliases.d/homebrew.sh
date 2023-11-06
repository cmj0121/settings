#! /usr/bin/env bash
#
# The extra settings for Homebrew.

if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

if ! command -v brew &>/dev/null; then
	return
fi

HOMEBREW=$(brew --prefix)

# shellcheck disable=SC1091
[[ -r "${HOMEBREW}/etc/profile.d/bash_completion.sh" ]] && . "${HOMEBREW}/etc/profile.d/bash_completion.sh"
