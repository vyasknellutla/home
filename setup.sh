#!/usr/bin/env sh
set -e
set -u
set -x

# shellcheck source=.profile
. "${HOME}/.profile"

# Symlinks
if [ -f "${CONFIG_HOME}/Code/User/settings.json" ]; then
    mkdir -p "${HOME}/.vscode-server/data/Machine"
    ln -sfn "${CONFIG_HOME}/Code/User" "${HOME}/.vscode-server/data/Machine"
    ln -sfn "${CONFIG_HOME}/Code/User/settings.json" "${HOME}/.vscode-server/data/Machine/settings.json"
fi

# Setup Homebrew
if ! [ -d "${HOMEBREW_HOME}" ]; then
    mkdir -p "${HOMEBREW_HOME}"
    chown -R vyas "${HOMEBREW_HOME}"
    curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C "${HOMEBREW_HOME}"
fi

# if [ -x "$(command -v brew)" ]; then
#     brew update --force && brew upgrade && brew cleanup
#     brew install --display-times --force-bottle direnv fish git gpg
# fi

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
# if ! grep -qi 'fs.inotify.max_user_watches' /etc/sysctl.conf; then
#     sudo "${SHELL}" -c "echo 'fs.inotify.max_user_watches=524288' >> /etc/sysctl.conf"
#     sudo sysctl -p
# fi

# # Docker TODO: Ansible Role
# if [ -x "$(command -v docker)" ]; then
#     sudo addgroup --system docker
#     sudo adduser "${USER}" docker
#     newgrp docker
#     sudo gpasswd -a "${USER}" docker
# fi

python3 -m pip install --user ansible pipenv
ansible-playbook "${HOME}/setup.playbook.yaml"