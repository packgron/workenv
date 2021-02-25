#!/usr/bin/zsh
# see /usr/share/doc/bash/examples/startup-files for examples.

# the default umask is set in /etc/profile; for setting the umask

export EDITOR=nvim
export TBROWSER=elinks
export WWW_HOME=https://duckduckgo.com
export FILEMANAGER=ranger
export SSH_AUTH_SOCK="$HOME/.ssh/ssh-agent.sock"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# if running zsh
if [ -n "$ZSH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.zshrc" ]; then
	. "$HOME/.zshrc"
    fi
fi


source "$HOME/.cargo/env"
