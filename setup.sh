#!/usr/bin/env sh
set -e
set -u
set -x

if [ -f "${HOME}/.profile" ]; then
    # shellcheck disable=SC1090
    . "${HOME}/.profile"

    ## Bulk actions
    # shellcheck disable=SC2039
    echo -e "$(printenv)" | while IFS="$(echo -en "\n\b")" read -r line; do
        key="${line%%=*}"
        value="${line#*=}"

        # Create Parent Directory's of all paths
        if dirname "${value}" > /dev/null 2> /dev/null && [ -d "$(dirname "$(dirname "${value}")")" ]; then
            mkdir -p "$(dirname "${value}")"
        fi

        # Expose variables to macOS GUI/System Applications
        if [ "$(uname -s)" = "Darwin" ]; then # If using macOS
            launchctl setenv "${key}" "${value}"
        fi
    done
fi

# Symlinks
if [ -f "${CONFIG_HOME}/Code/User/settings.json" ]; then
    mkdir -p "${HOME}/.vscode-server/data/Machine"
    ln -sfn "${CONFIG_HOME}/Code/User" "${HOME}/.vscode-server/data/Machine"
    ln -sfn "${CONFIG_HOME}/Code/User/settings.json" "${HOME}/.vscode-server/data/Machine/settings.json"
fi

if [ -x "$(command -v python3)" ]; then
    echo "Found Python 3, no need to install it!"
    # Python 3 is already installed, we don't need to do anything
elif [ -x "$(command -v apt-get)" ]; then
    if [ -x "$(command -v sudo)" ]; then
        sudo apt-get update
        sudo apt-get install -y python3 python3-pip
    else
        apt-get update
        apt-get install -y python3 python3-pip
    fi
elif [ -x "$(command -v dnf)" ]; then
    if [ -x "$(command -v sudo)" ]; then
        sudo dnf check-update
        sudo dnf install -y python3
    else
        dnf check-update
        dnf install -y python3
    fi
elif [ -x "$(command -v yum)" ]; then
    if [ -x "$(command -v sudo)" ]; then
        sudo yum check-update
        sudo yum install -y python3 
    else
        yum check-update
        yum install -y python3
    fi
elif [ -x "$(command -v apk)" ]; then
    if [ -x "$(command -v sudo)" ]; then
        sudo apk update
        sudo apk add python3
    else
        apk update
        apk add python3
    fi
else
    echo "Python 3 was not found and I couldn't find a way to install it!"
    exit 1
fi

# Setup Homebrew
# if ! [ -d "${HOMEBREW_HOME}" ]; then
#     mkdir -p "${HOMEBREW_HOME}"
#     chown -R vyas "${HOMEBREW_HOME}"
#     curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C "${HOMEBREW_HOME}"
# fi

# if [ -x "$(command -v rustup-init)" ]; then
#     rustup-init --no-modify-path -y
# fi

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

pip3 install --user ansible pipenv pip
ansible-playbook "${HOME}/setup.playbook.yaml"