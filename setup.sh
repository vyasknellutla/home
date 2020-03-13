#!/bin/sh

if [ "${USER}" = "root" ]; then # TODO: Add condition, user vyas doesn't exist
    adduser --gecos "" vyas     # TODO: automate password
    adduser vyas sudo
    if [ -d "${HOME}/.ssh" ]; then
        mkdir -p ~vyas/.ssh
        cat "${HOME}/.ssh/authorized_keys" >~vyas/.ssh/authorized_keys
        chown -R vyas ~vyas

        if [ -f "/etc/ssh/sshd_config" ]; then
            sed -i 's/#PermitRootLogin no/PermitRootLogin no/g' /etc/ssh/sshd_config
            sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
            /etc/init.d/ssh restart
        fi
    fi
    # TODO: Switch user to vyas
    ## exec su "vyas" "$0" -- "$@" : exits with code 127
fi
if [ "${USER}" = "vyas" ]; then
    . ~/.envrc

    # Setup dotfiles
    cd "${HOME}" # TODO remove
    if ! [ -d "${HOME}/.git" ]; then
        git init "${HOME}"
        git remote add origin https://github.com/vyasknellutla/dotfiles.git
        git fetch origin
        git checkout --force -b master --track origin/master
    fi

    # Update system
    ## TODO: check if user is a part of sudo
    if [ -x "$(command -v apt)" ]; then
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

        # Check for sudo permissions
        if [ -x "$(command -v fish)" ]; then
            if ! [ grep -qi "$(command -v fish)" /etc/shells ]; then
                sudo command -v fish >>/etc/shells
            fi
            ## TODO: VSCode Remote SSH fails with custom shell
            # sudo chsh --shell "$(command -v fish)" "${USER}"
        fi

        brew bundle install --global
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
    if ! [ grep -qi 'fs.inotify.max_user_watches' /etc/sysctl.conf ]; then
        sudo $SHELL -c 'echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf'
        sudo sysctl -p
    fi

    # Symlinks
    if [ -f "${CONFIG_HOME}/Code/User/settings.json" ]; then
        mkdir -p "${HOME}/.vscode-server/data/Machine"
        ln -sfn "${CONFIG_HOME}/Code/User" "${HOME}/.vscode-server/data/Machine"
        ln -sfn "${CONFIG_HOME}/Code/User/settings.json" "${HOME}/.vscode-server/data/Machine/settings.json"
    fi

    if [ -f "${HOME}/.profile" ]; then
        ln -sfn "${HOME}/.profile" "${HOME}/.bash_profile"
    fi

    if [ -f "${HOME}/.logout" ]; then
        ln -sfn "${HOME}/.logout" "${HOME}/.bash_logout"
    fi
fi
