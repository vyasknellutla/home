#!/usr/bin/env fish

## direnv: https://direnv.net/docs/hook.html#fish
set PATH /home/linuxbrew/.linuxbrew/bin $PATH
### Workaround from: https://github.com/direnv/direnv/issues/583#issuecomment-626109571
function __direnv_export_eval --on-event fish_prompt
    # Run on each prompt to update the state
    if type -q direnv
        direnv export fish | source
    end

    # Handle cd history arrows between now and the next prompt
    function __direnv_cd_hook --on-variable PWD
        # ensure any output overwrites the prompt instead of going after it
        echo -ne '\r'
        # run the outer function to apply any changes
        __direnv_export_eval
    end

    function __direnv_disable_cd --on-event fish_preexec
        # Once we're running commands, stop monitoring cd changes
        # until we get to the prompt again
        functions --erase __direnv_cd_hook
    end
end

## Fish Exit/Logout
function on_exit --on-process %self
    echo "Exiting Fish Shell, see you next time"
    if [ -x $HOME/.logout ]
        $HOME/.logout
    end
    sleep 1
end
