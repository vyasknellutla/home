#!/bin/sh

## Proxy

## Path Variable
# UNIX System Paths
export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
export HOME="${HOME:-$(~)}"
export USER="${USER:-$(id --user --name)}"

## XDG Base Dir Spec
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"

# User Paths
export DATA_HOME="${XDG_DATA_HOME}"
export CONFIG_HOME="${XDG_CONFIG_HOME}"
export CACHE_HOME="${XDG_CACHE_HOME}"
export PATH="${HOME}/bin:${HOME}/sbin:${PATH}"

export DIRENV="${CONFIG_HOME}/direnv"

## Package Managers
# Snap
export PATH="/snap/bin:${PATH}"

# HomeBrew
if [ -x "$(command -v brew)" ]; then
    export HOMEBREW_HOME="$(brew --prefix)"
fi
export HOMEBREW_HOME="${HOMEBREW_HOME:-"/home/linuxbrew/.linuxbrew"}"
export HOMEBREW_CACHE="${CACHE_HOME}/homebrew"

export PATH="${HOMEBREW_HOME}/bin:${HOMEBREW_HOME}/sbin:${PATH}"

# Pip (user-level)
export PYTHONUSERBASE="${DATA_HOME}/pip"
export PATH="${PYTHONUSERBASE}/bin:${PATH}"

## SHIM Paths
# Golang: https://github.com/syndbg/goenv/blob/master/ENVIRONMENT_VARIABLES.md#environment-variables
export GOENV_ROOT="${CONFIG_HOME}/goenv"

# Java: No source, just precedent
export JENV_ROOT="${CONFIG_HOME}/jenv"

# Node.js
export NPM_HOME="${CONFIG_HOME}/npm"
# https://github.com/nodenv/nodenv#environment-variables
export NODENV_ROOT="${CONFIG_HOME}/nodenv"

# Perl: No source, just precedent
export PLENV_ROOT="${CONFIG_HOME}/plenv"

# Python: https://github.com/pyenv/pyenv#environment-variables
export PYENV_ROOT="${CONFIG_HOME}/pyenv"

# Ruby: https://github.com/rbenv/rbenv#environment-variables
export RBENV_ROOT="${CONFIG_HOME}/rbenv"

# Rust
# https://github.com/rust-lang/rustup#environment-variables
export RUSTUP_HOME="${DATA_HOME}/rustup"
# https://doc.rust-lang.org/cargo/reference/environment-variables.html#environment-variables-cargo-reads
export CARGO_HOME="${DATA_HOME}/cargo"

export PATH="${GOENV_ROOT}/shims:${JENV_ROOT}/shims:${NODENV_ROOT}/shims:${PLENV_ROOT}/shims:${PYENV_ROOT}/shims:${RBENV_ROOT}/shims:${CARGO_HOME}/bin:${PATH}"

## C/C++ Complier Flags
# C PreProcessor (C/C++)
export CPPFLAGS="-Ofast -pipe -march=native -I/usr/local/include $(echo "${HOMEBREW_HOME}"/opt/*/include | sed 's/ / -I/g')"
export LDFLAGS="-L/usr/local/lib $(echo "${HOMEBREW_HOME}"/opt/*/lib | sed 's/ / -L/g')"

# C complier
export CC="$(command -v gcc)"
export CFLAGS="${CPPFLAGS}"

# C++ complier
export CXX="$(command -v g++)"
export CXXFLAGS="${CPPFLAGS}"

## CLI Tools
# ls
export CLICOLOR=1
export LSCOLORS="gxBxhxDxfxhxhxhxhxcxcx"

# Editors
if [ -x "$(command -v code)" ]; then # Check if VS Code is installed
    export EDITOR="code -w"
    export VISUAL="code -w"
elif [ -x "$(command -v vim)" ]; then
    export EDITOR="vim"
    export VISUAL="vim"
else
    export EDITOR="vi"
    export VISUAL="vi"
fi

# VirtualBox: https://github.com/hashicorp/vagrant/issues/3532#issuecomment-41321828
export VBOX_USER_HOME="${DATA_HOME}/virtualbox"

# Vagrant: https://www.vagrantup.com/docs/other/environmental-variables.html
export VAGRANT_HOME="${DATA_HOME}/vagrant"

# Packer: https://www.packer.io/docs/other/environment-variables.html
export PACKER_CACHE_DIR="${CACHE_HOME}/packer"
export PACKER_CONFIG_DIR="${CONFIG_HOME}/packer"

# GPG: https://www.gnupg.org/documentation/manuals/gnupg/GPG-Configuration.html
export GNUPGHOME="${CONFIG_HOME}/gnupg"

# Docker
export DOCKER_HOST="unix:///var/run/docker.sock"

## Cloud Providers
# AWS
export AWS_CONFIG_FILE="${CONFIG_HOME}/aws/config"                  # https://docs.aws.amazon.com/cli/latest/topic/config-vars.html#general-options
export AWS_SHARED_CREDENTIALS_FILE="${CONFIG_HOME}/aws/credentials" # https://docs.aws.amazon.com/cli/latest/topic/config-vars.html#the-shared-credentials-file

# Azure
export AZURE_CONFIG_DIR="${CONFIG_HOME}/azure"

## OS Specific
if [ "$(uname -s)" = "Darwin" ]; then # Check if using macOS
    ## HOMEBREW
    export PKG_CONFIG_PATH="${HOMEBREW_HOME}/opt/*/lib/pkgconfig"

    ## Java Paths
    ## TODO: Replace with jenv shim
    export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"

    ## Android Paths
    export ANDROID_HOME="${HOME}/Library/Android/sdk"
    export PATH="${ANDROID_HOME}:tools/bin:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${PATH}"

    ## Flutter Paths
    export PATH="${HOME}/Library/Flutter/flutter/bin:${PATH}"

    ## DotNet tools
    export PATH="/usr/local/share/dotnet:${PATH}"

    # TODO use launchctl setenv PATH $PATH
    # For all environment vairables
elif [ "$(uname --operating-system)" = "Msys" ]; then # Check if Windows using MinGW or Git-Bash
    export PATH="/mingw64/bin:${PATH}"
fi

# If not running interactively, don't do anything
! tty -s && return

# Bash Specific
if [ -n "$(/bin/bash -c 'echo ${BASH_VERSION}')" ]; then
    # Alias definitions.
    # You may want to put all your additions into a separate file like
    # ~/.bash_aliases, instead of adding them here directly.
    # See /usr/share/doc/bash-doc/examples in the bash-doc package.
    if [ -f "${HOME}/.bash_aliases" ]; then
        . "${HOME}/.bash_aliases"
    fi

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
        . "${HOMEBREW_HOME}/etc/bash_completion"
    fi

    # Pip
    _pip_completion() {
        COMPREPLY=($(COMP_WORDS="${COMP_WORDS[*]}" \
            COMP_CWORD=$COMP_CWORD \
            PIP_AUTO_COMPLETE=1 $1 2>/dev/null))
    }
    complete -o default -F _pip_completion pip
    complete -o default -F _pip_completion pip3
fi
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
# shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

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
#force_color_prompt=yes

if [ -n "${force_color_prompt}" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
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
    test -r "${HOME}/.dircolors" && eval "$(dircolors -b "${HOME}"/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
