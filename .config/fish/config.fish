#!/usr/bin/env fish

## direnv: https://direnv.net/docs/hook.html#fish
set -x PATH /home/linuxbrew/.linuxbrew/bin $PATH
if type -q direnv
    set -e fish_user_paths
    eval (direnv hook fish)
end


## Package Managers
# HomeBrew
if type -q brew
    set -x LDFLAGS (string replace -- (brew --prefix) -L(brew --prefix) (brew --prefix)/opt/*/lib) $LDFLAGS
    set -x CPPFLAGS -Ofast (string replace -- (brew --prefix) -I(brew --prefix) (brew --prefix)/opt/*/include) $CPPFLAGS
    set -x CFLAGS $CPPFLAGS

    if [ (uname -s) = "Darwin" ]
        set -x PKG_CONFIG_PATH (brew --prefix)/opt/*/lib/pkgconfig
    end
end


## SHIMS
if status --is-interactive
    if type -q goenv
        goenv rehash
    end

    if type -q jenv
        jenv rehash
    end

    if type -q nodenv
        nodenv rehash
    end

    if type -q plenv
        plenv rehash
    end

    if type -q pyenv
        pyenv rehash
    end

    if type -q rbenv
        rbenv rehash
    end
end


## Fish Exit/Logout
function on_exit --on-process %self
    echo "Exiting Fish Shell, see you next time"
    if [ -e $HOME/.logout ]
        $HOME/.logout
    end
    sleep 1
end
