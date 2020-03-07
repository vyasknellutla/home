#!/usr/bin/env sh

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [[ -n "$BASH_VERSION" ]]; then
    # include .bashrc if it exists
    if [[ -f "$HOME/.bashrc" ]]; then
	    source "$HOME/.bashrc"
    fi

    # begin bash_completion configuration
    if [[ -f /usr/share/bash-completion/bash_completion ]]; then
        source /usr/share/bash-completion/bash_completion
    fi
    if [[ -f /etc/bash_completion ]]; then
        source /etc/bash_completion
    fi
    # end bash_completion configuration
fi

# set PATH so it includes user's private bin if it exists
if [[ -d "$HOME/bin" ]] ; then
    PATH="$HOME/bin:$PATH"
fi
if [[ -d "$HOME/sbin" ]] ; then
    PATH="$HOME/sbin:$PATH"
fi

# set PATH so it includes user's local private bin if it exists
if [[ -d "$HOME/.local/bin" ]] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [[ -d "$HOME/.local/sbin" ]] ; then
    PATH="$HOME/.local/sbin:$PATH"
fi

# set PATH so it includes snap packages
if [[ -d "/snap/bin/" ]] ; then
    PATH="/snap/bin/:$PATH"
fi

# LSCOLORS
export CLICOLOR=1
export LSCOLORS='gxBxhxDxfxhxhxhxhxcxcx';


### Setup Brew Package Manager

if [[ -x "$(command -v brew)" ]] && [[ -d "$(brew --prefix)/bin" ]]; then
    PATH="$(brew --prefix)/bin:$PATH"

    # Adds completions for packages installed by brew
    if [[ -f $(brew --prefix)/etc/bash_completion ]]; then
        source $(brew --prefix)/etc/bash_completion
    fi

    # TODO change to if exists
    PATH="$(brew --prefix)/opt/findutils/libexec/gnubin:$PATH"
    PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
fi

### General Setup
PATH="$HOME/snap/bin:$PATH"
export EDITOR="code -w"
export VISUAL="code -w"

# Docker from host
export DOCKER_HOST="unix:///var/run/docker.sock"

# SSH key management
if [[ -f "$HOME/.ssh/id_rsa" ]]; then
    ssh-add -k ~/.ssh/id_rsa
fi
