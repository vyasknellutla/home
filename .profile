#!/usr/bin/env sh
set -e
set -u

## Custom Config
if [ -f "${HOME}/.envrc" ]; then
    # shellcheck disable=SC1090
    . "${HOME}/.envrc"
fi


## Path Variable
# UNIX System Paths
export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
export HOME="${HOME:-$(~)}"
export USER="${USER:-$(id --user --name)}"

## XDG Base Dir Spec
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# Note: Many applications don't natively support XDG Base Dir Spec, so workarounds are implemented either by symlinks or according to this doc: https://wiki.archlinux.org/index.php/XDG_Base_Directory
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"

# User Paths
export DATA_HOME="${XDG_DATA_HOME}"
export CONFIG_HOME="${XDG_CONFIG_HOME}"
export CACHE_HOME="${XDG_CACHE_HOME}"
export PATH="${HOME}/bin:${HOME}/sbin:${PATH}"

## Shell Configs
# Language
export LANG="en_US.UTF-8"

# Colors
export CLICOLOR=1
export LSCOLORS="gxBxhxDxfxhxhxhxhxcxcx"

# Editors
if [ -x "$(command -v vim)" ]; then
    export EDITOR="vim"
    export VISUAL="vim"
else
    export EDITOR="vi"
    export VISUAL="vi"
fi

## Package Managers
# HomeBrew
if [ -x "$(command -v brew)" ]; then
    HOMEBREW_HOME="$(brew --prefix)"
    export HOMEBREW_HOME
fi
if [ "$(uname -s)" = "Darwin" ]; then # Check if using macOS
    export HOMEBREW_HOME="${HOMEBREW_HOME:-"/usr/local"}"
else
    export HOMEBREW_HOME="${HOMEBREW_HOME:-"/home/linuxbrew/.linuxbrew"}"
fi
export HOMEBREW_CACHE="${CACHE_HOME}/homebrew"
export PATH="${HOMEBREW_HOME}/bin:${HOMEBREW_HOME}/sbin:${PATH}"

# Nix
if [ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ]; then
    # shellcheck disable=SC1090
    . "${HOME}/.nix-profile/etc/profile.d/nix.sh"
fi

# Snap
export PATH="/snap/bin:${PATH}"

# Whalebrew: https://github.com/whalebrew/whalebrew#configuration
export WHALEBREW_CONFIG_DIR="${CONFIG_HOME}/whalebrew"
export WHALEBREW_INSTALL_PATH="${DATA_HOME}/whalebrew"
export PATH="${WHALEBREW_INSTALL_PATH}:${PATH}"

## Programming Language & Packages
# ASDF
export ASDF_DIR="${HOMEBREW_HOME}/opt/asdf"
export ASDF_DATA_DIR="${DATA_HOME}/asdf"
export ASDF_CONFIG_FILE="${CONFIG_HOME}/asdf/.asdfrc"

export ASDF_BIN="${ASDF_DIR}/bin"
export ASDF_USER_SHIMS="${ASDF_DATA_DIR}/shims"

export PATH="${ASDF_USER_SHIMS}:${ASDF_BIN}:${PATH}"

# C/C++:
if [ -x "$(command -v gcc)" ] && [ -x "$(command -v g++)" ]; then
    export CC="gcc"
    export CXX="g++"
fi

CPPFLAGS="-Ofast -pipe -march=native -I/usr/local/include"
LDFLAGS="-L/usr/local/lib"
if [ -x "$(command -v brew)" ]; then
    CPPFLAGS="${CPPFLAGS} $(echo "${HOMEBREW_HOME}"/opt/*/include | sed 's/ / -I/g')"
    LDFLAGS="${LDFLAGS} $(echo "${HOMEBREW_HOME}"/opt/*/lib | sed 's/ / -L/g')"
fi
export CPPFLAGS
export CFLAGS="${CPPFLAGS}"
export CXXFLAGS="${CPPFLAGS}"
export LDFLAGS

# elm: https://github.com/stil4m/elm-analyse/issues/229#issue-571057137
export ELM_HOME="${CACHE_HOME}/elm"

export GOPATH="${DATA_HOME}/go"

# Java:
export GRADLE_USER_HOME="${DATA_HOME}/gradle"

# Node.js
export NPM_CONFIG_USERCONFIG="${CONFIG_HOME}/npm/npmrc"

export PATH="${DATA_HOME}/npm/bin:${PATH}"

# Python: https://github.com/pyenv/pyenv#environment-variables
export PYTHONUSERBASE="${DATA_HOME}/pip"

export PATH="${PYTHONUSERBASE}/bin:${PATH}"

# Ruby:
## - https://wiki.archlinux.org/index.php/XDG_Base_Directory#Partial
export BUNDLE_USER_CONFIG="${CONFIG_HOME}/bundle"
export BUNDLE_USER_CACHE="${CACHE_HOME}/bundle"
export BUNDLE_USER_PLUGIN="${DATA_HOME}/bundle"

export GEM_HOME="${DATA_HOME}/gem"
export GEM_SPEC_CACHE="${CACHE_HOME}/gem"

# Rust:
## - https://github.com/rust-lang/rustup#environment-variables
## - https://doc.rust-lang.org/cargo/reference/environment-variables.html#environment-variables-cargo-reads
export RUSTUP_HOME="${DATA_HOME}/rustup"

export CARGO_HOME="${DATA_HOME}/cargo"

export PATH="${CARGO_HOME}/bin:${PATH}"

## CLI Tools
# direnv
export DIRENV="${CONFIG_HOME}/direnv"

# Docker: https://wiki.archlinux.org/index.php/XDG_Base_Directory#Partial
export DOCKER_HOST="unix:///var/run/docker.sock"
export DOCKER_CONFIG="${CONFIG_HOME}/docker"

# GPG: https://www.gnupg.org/documentation/manuals/gnupg/GPG-Configuration.html
export GNUPGHOME="${CONFIG_HOME}/gnupg"

# Packer: https://www.packer.io/docs/other/environment-variables.html
export PACKER_CACHE_DIR="${CACHE_HOME}/packer"
export PACKER_CONFIG_DIR="${CONFIG_HOME}/packer"

# Terraform: https://www.terraform.io/docs/commands/environment-variables.html#tf_cli_config_file
export TF_CLI_CONFIG_FILE="${CONFIG_HOME}/terraform/.terraformrc"

# Vagrant: https://www.vagrantup.com/docs/other/environmental-variables.html
export VAGRANT_HOME="${DATA_HOME}/vagrant"
export VAGRANT_ALIAS_FILE="${DATA_HOME}/vagrant/aliases"

# VirtualBox: https://github.com/hashicorp/vagrant/issues/3532#issuecomment-41321828
export VBOX_USER_HOME="${DATA_HOME}/virtualbox"

## Cloud Providers
# AWS
export AWS_CONFIG_FILE="${CONFIG_HOME}/aws/config"                  # https://docs.aws.amazon.com/cli/latest/topic/config-vars.html#general-options
export AWS_SHARED_CREDENTIALS_FILE="${DATA_HOME}/aws/credentials" # https://docs.aws.amazon.com/cli/latest/topic/config-vars.html#the-shared-credentials-file

# Azure
export AZURE_CONFIG_DIR="${CONFIG_HOME}/azure"

## OS Specific
if [ "$(uname -s)" = "Darwin" ]; then # If using macOS
    ## HOMEBREW
    export PKG_CONFIG_PATH="${HOMEBREW_HOME}/opt/*/lib/pkgconfig"

    ## Android Paths
    export ANDROID_HOME="${HOME}/Library/Android/sdk"
    export PATH="${ANDROID_HOME}:tools/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${PATH}"

    ## Flutter Paths
    export PATH="${HOME}/Library/Flutter/flutter/bin:${PATH}"

    ## DotNet tools
    export PATH="/usr/local/share/dotnet:${PATH}"
elif [ "$(uname -s)" = "Linux" ]; then # If using Linux
    echo "Linux!"
fi

# If not running interactively, don't do anything after this point
! tty -s && return

# Shell Specific
if [ "${0}" = "bash" ]; then
    # don't put duplicate lines or lines starting with space in the history.
    # See bash(1) for more options
    HISTCONTROL=ignoreboth
    # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
    HISTSIZE=1000
    HISTFILESIZE=2000

    # Alias definitions.
    # You may want to put all your additions into a separate file like
    # ~/.bash_aliases, instead of adding them here directly.
    # See /usr/share/doc/bash-doc/examples in the bash-doc package.
    # if [ -f "${HOME}/.bash_aliases" ]; then
    #     . "${HOME}/.bash_aliases"
    # fi

    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    # if [ -f "/usr/share/bash-completion/bash_completion" ]; then
    #     . "/usr/share/bash-completion/bash_completion"
    # fi
    # if [ -f "/etc/bash_completion" ]; then
    #     . "/etc/bash_completion"
    # fi

    # Adds completions for packages installed by brew
    if [ -f "${HOMEBREW_HOME}/etc/bash_completion" ]; then
        # shellcheck disable=SC1090
        . "${HOMEBREW_HOME}/etc/bash_completion"
    fi

    # Pip
    if [ -x "$(command -v pip3)" ]; then
        eval "$(pip3 completion --bash)"
    fi
    if [ -x "$(command -v pip)" ]; then
        eval "$(pip completion --bash)"
    fi
fi

# append to the history file, don't overwrite it
# shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
# shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "${TERM}" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "${force_color_prompt}" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >/dev/null 2>/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "${color_prompt}" = yes ]; then
    PS1="${debian_chroot:+(${debian_chroot})}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
else
    PS1="${debian_chroot:+(${debian_chroot})}\u@\h:\w\$ "
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "${TERM}" in
xterm* | rxvt*) PS1="\[\e]0;${debian_chroot:+(${debian_chroot})}\u@\h: \w\a\]${PS1}" ;;
*) ;;
esac

### Aliases

# enable color support of ls and also add handy aliases
if [ -x "/usr/bin/dircolors" ]; then
    if [ -r "${HOME}/.dircolors" ]; then
        eval "$(dircolors -b "${HOME}"/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'
    # alias dir='dir --color=auto'
    # alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
# export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
