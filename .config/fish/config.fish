#!/usr/bin/env fish

## Path Variable
# UNIX System Paths
set -e PATH
set -e fish_user_paths
set -x fish_user_paths /bin
set -x fish_user_paths /sbin $fish_user_paths
set -x fish_user_paths /usr/bin $fish_user_paths
set -x fish_user_paths /usr/sbin $fish_user_paths
set -x fish_user_paths /usr/local/bin $fish_user_paths
set -x fish_user_paths /usr/local/sbin $fish_user_paths

## XDG Base Dir Spec
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
set -x XDG_DATA_HOME $HOME/.local/share
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache

# User Paths
set -x DATA_HOME $XDG_DATA_HOME
set -x CONFIG_HOME $XDG_CONFIG_HOME
set -x CACHE_HOME $XDG_CACHE_HOME
set -x fish_user_paths $HOME/bin $fish_user_paths
set -x fish_user_paths $HOME/sbin $fish_user_paths

## Package Managers
# Snap
if type -q snap
    if [ -e /snap ]
        set -x fish_user_paths /snap $fish_user_paths
    end
    if [ -e $HOME/snap ]
        set -x fish_user_paths $HOME/snap $fish_user_paths
    end
end
# HomeBrew
if type -q brew
    set -x LDFLAGS (string replace -- (brew --prefix) -L(brew --prefix) (brew --prefix)/opt/*/lib)
    set -x CFLAGS -Ofast (string replace -- (brew --prefix) -I(brew --prefix) (brew --prefix)/opt/*/include)
    set -x CPPFLAGS $CFLAGS

    if [ (uname -s) = "Darwin" ]
        set -x PKG_CONFIG_PATH (brew --prefix)/opt/*/lib/pkgconfig
    end

    set -x fish_user_paths (brew --prefix)/bin $fish_user_paths
    set -x fish_user_paths (brew --prefix)/sbin $fish_user_paths
end


## SHIM Paths
if status --is-interactive
    # Golang
    if type -q goenv
        # https://github.com/syndbg/goenv/blob/master/ENVIRONMENT_VARIABLES.md#environment-variables
        set -x GOENV_ROOT $CONFIG_HOME/goenv
        set -x fish_user_paths $GOENV_ROOT/shims $fish_user_paths

        goenv rehash
    end
    # Java
    if type -q jenv
        # No source, just precedent
        set -x JENV_ROOT $CONFIG_HOME/jenv
        set -x fish_user_paths $JENV_ROOT/shims $fish_user_paths

        jenv rehash
    end
    # Node.js
    if type -q nodenv
        # https://github.com/nodenv/nodenv#environment-variables
        set -x NODENV_ROOT $CONFIG_HOME/nodenv
        set -x fish_user_paths $NODENV_ROOT/shims $fish_user_paths

        nodenv rehash
    end
    # Perl
    if type -q plenv
        set -x PLENV_ROOT $CONFIG_HOME/plenv
        set -x fish_user_paths $PLENV_ROOT/shims $fish_user_paths

        plenv rehash
    end
    # Python
    if type -q pyenv
        # https://github.com/pyenv/pyenv#environment-variables
        set -x PYENV_ROOT $CONFIG_HOME/pyenv
        set -x fish_user_paths $PYENV_ROOT/shims $fish_user_paths

        pyenv rehash
    end
    # Ruby
    if type -q rbenv
        # https://github.com/rbenv/rbenv#environment-variables
        set -x RBENV_ROOT $CONFIG_HOME/rbenv
        set -x fish_user_paths $RBENV_ROOT/shims $fish_user_paths

        rbenv rehash
    end
    # Rust
    if type -q rustup-init
        # https://github.com/rust-lang/rustup#environment-variables
        set -x RUSTUP_HOME $CONFIG_HOME/rustup

        # https://doc.rust-lang.org/cargo/reference/environment-variables.html#environment-variables-cargo-reads
        set -x CARGO_HOME $CONFIG_HOME/cargo
        set -x fish_user_paths $CARGO_HOME/bin $fish_user_paths
    end
end

## Environment variables
# Editors
if type -q code # Check if VS Code is installed
    set -x EDITOR code -w
    set -x VISUAL code -w
else if type -q vim
    set -x EDITOR vim
    set -x VISUAL vim
else
    set -x EDITOR vi
    set -x VISUAL vi
end

## Cloud Providers
# AWS
set -x AWS_CONFIG_FILE $CONFIG_HOME/aws/config # https://docs.aws.amazon.com/cli/latest/topic/config-vars.html#general-options
set -x AWS_SHARED_CREDENTIALS_FILE $CONFIG_HOME/aws/credentials # https://docs.aws.amazon.com/cli/latest/topic/config-vars.html#the-shared-credentials-file

# Azure
set -x AZURE_CONFIG_DIR $CONFIG_HOME/azure

## OS Specific
if [ (uname -s) = "Darwin" ] # Check if using macOS
    ## Java Paths
    ## TODO: Replace with jenv shim
    set -x JAVA_HOME /Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home

    ## Android Paths
    set -x ANDROID_HOME $HOME/Library/Android/sdk
    set -x fish_user_paths $ANDROID_HOME/platform-tools $fish_user_paths
    set -x fish_user_paths $ANDROID_HOME/tools $fish_user_paths
    set -x fish_user_paths $ANDROID_HOME/tools/bin $fish_user_paths

    ## Flutter Paths
    set -x fish_user_paths $HOME/Library/Flutter/flutter/bin $fish_user_paths

    ## DotNet tools
    set -x fish_user_paths /usr/local/share/dotnet $fish_user_paths
end

## CLI Tools
# GPG
if type -q gpg
    # https://www.gnupg.org/documentation/manuals/gnupg/GPG-Configuration.html
    set -x GNUPGHOME $CONFIG_HOME/gnupg
end

## Fish Exit/Logout
function on_exit --on-process %self
    echo "Exiting Fish Shell, see you next time"
    if [ -e $HOME/.logout ]
        $HOME/.logout
    end
    sleep 1
end