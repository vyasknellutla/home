#!/bin/sh

# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "${BASH_VERSION}" ]; then
    # include .bashrc if it exists
    if [ -f "${HOME}/.bashrc" ]; then
        . "${HOME}/.bashrc"
    fi

    # begin bash_completion configuration
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    fi
    if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi

    # Adds completions for packages installed by brew
    if [ -f "${HOMEBREW_HOME}/etc/bash_completion" ]; then
        . "${HOMEBREW_HOME}/etc/bash_completion"
    fi
    # end bash_completion configuration
fi

# SSH key management
if [ -f "${HOME}/.ssh/id_rsa" ]; then
    ssh-add -k ~/.ssh/id_rsa
fi
