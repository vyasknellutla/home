#!/usr/bin/env fish

## direnv: https://direnv.net/docs/hook.html#fish
if [ -d "/home/linuxbrew/.linuxbrew/bin" ]
    set PATH "/home/linuxbrew/.linuxbrew/bin" $PATH
end

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

## Fisher: https://github.com/jorgebucaran/fisher#bootstrap-installation
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME "$HOME/.config"
    if type -q curl
        curl https://git.io/fisher --create-dirs -sLo "$XDG_CONFIG_HOME/fish/functions/fisher.fish"
        fish -c fisher
    end
end

## Fish Exit/Logout
function on_exit --on-process %self
    if [ -x "$HOME/.logout" ]
        $HOME/.logout
    end
end
