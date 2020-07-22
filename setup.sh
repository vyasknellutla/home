#!/bin/sh

# shellcheck source=.profile
. "${HOME}/.profile"

# Setup dotfiles
cd "${HOME}" || exit # TODO remove
if ! [ -d "${HOME}/.git" ]; then
    git init "${HOME}"
    git remote add origin https://github.com/vyasknellutla/dotfiles.git
    git fetch origin
    git checkout --force -b master --track origin/master
fi

# Symlinks
if [ -f "${CONFIG_HOME}/Code/User/settings.json" ]; then
    mkdir -p "${HOME}/.vscode-server/data/Machine"
    ln -sfn "${CONFIG_HOME}/Code/User" "${HOME}/.vscode-server/data/Machine"
    ln -sfn "${CONFIG_HOME}/Code/User/settings.json" "${HOME}/.vscode-server/data/Machine/settings.json"
fi

# Update system
## TODO: check if user is a part of sudo
if [ -x "$(command -v apt-get)" ]; then
    sudo apt update -y && sudo apt full-upgrade -y && sudo apt autoremove -y

    # Install Homebrew Dependencies: https://docs.brew.sh/Homebrew-on-Linux#debian-or-ubuntu
    sudo apt-get install build-essential curl file git -y
elif [ -x "$(command -v yum)" ]; then
    sudo yum update -y

    # Install Homebrew Dependencies: https://docs.brew.sh/Homebrew-on-Linux#fedora-centos-or-red-hat
    sudo yum groupinstall 'Development Tools' --yes
    sudo yum install curl file git --yes
    sudo yum install libxcrypt-compat --yes # needed by Fedora 30 and up
fi

# Setup Homebrew
if ! [ -d "${HOMEBREW_HOME}" ]; then
    sudo mkdir -p "${HOMEBREW_HOME}"
    sudo chown -R vyas "${HOMEBREW_HOME}"
    curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C "${HOMEBREW_HOME}"
fi

if [ -x "$(command -v brew)" ]; then
    brew update --force && brew upgrade && brew cleanup
    brew install --display-times --force-bottle direnv fish git gpg

    brew bundle install --global

    #       brew link "$(brew leaves)"
fi

if [ -x "$(command -v rustup-init)" ]; then
    rustup-init --no-modify-path -y
fi

# Setup Shims
if [ -x "$(command -v goenv)" ]; then
    goenv install --skip-existing "$(goenv global)" &
fi
if [ -x "$(command -v pyenv)" ]; then
    pyenv install --skip-existing "$(pyenv global)" &
fi
if [ -x "$(command -v rbenv)" ]; then
    rbenv install --skip-existing "$(rbenv global)" &
fi
if [ -x "$(command -v nodenv)" ]; then
    nodenv install --skip-existing "$(nodenv global)" &
fi

# VS Code setup
if ! grep -qi 'fs.inotify.max_user_watches' /etc/sysctl.conf; then
    sudo "${SHELL}" -c "echo 'fs.inotify.max_user_watches=524288' >> /etc/sysctl.conf"
    sudo sysctl -p
fi

# Docker
if [ -x "$(command -v docker)" ]; then
    sudo addgroup --system docker
    sudo adduser "${USER}" docker
    newgrp docker
    sudo gpasswd -a "${USER}" docker
fi

# SSH
if [ -f "${HOME}/.ssh/id_rsa" ]; then
    ssh-add -k "${HOME}/.ssh/id_rsa"
fi
