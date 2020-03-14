#!/usr/bin/env fish

## direnv: https://direnv.net/docs/hook.html#fish
set PATH /home/linuxbrew/.linuxbrew/bin $PATH
if type -q direnv
    direnv allow "$HOME/.envrc"
    eval (direnv hook fish)
end

## Fish Exit/Logout
function on_exit --on-process %self
    echo "Exiting Fish Shell, see you next time"
    if [ -x $HOME/.logout ]
        $HOME/.logout
    end
    sleep 1
end
