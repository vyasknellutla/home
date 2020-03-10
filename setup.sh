#!/bin/sh

if ! [ -x "$(command -v brew)" ]; then
    # TODO make commands non-interactive
    ## GRUB updates cause prompt
    if [ -x "$(command -v apt)" ]; then
        sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y

        sudo apt install linuxbrew-wrapper -y # TODO: make non-interactive (Replace with git clone into user's home directory)
    fi
fi

if [ -x "$(command -v brew)" ]; then
    PATH="$(brew --prefix)/bin:${PATH}"

    brew update --force && brew upgrade && brew cleanup
    brew install fish git gpg --display-times

    if [ -x "$(command -v fish)" ]; then
        sudo usermod --shell "$(which fish)" "${USER}"
    fi
fi

if [ -x "$(command -v rustup-init)" ]; then
    rustup-init --no-modify-path -y
fi

# Symlinks
if [ -f "${CONFIG_HOME}/Code/User/settings.json" ]; then
    mkdir -p "${HOME}/.vscode-server/data/Machine"
    ln -sfn "${CONFIG_HOME}/Code/User" "${HOME}/.vscode-server/data/Machine"
fi

if [ -f "${HOME}/.logout" ]; then
    ln -sfn "${HOME}/.logout" "${HOME}/.bash_logout"
fi
