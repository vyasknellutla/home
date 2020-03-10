#!/usr/bin/env zsh
# direnv: https://direnv.net/docs/hook.html#bash
if [ -x "$(command -v direnv)" ]; then
    eval "$(direnv hook zsh)"
fi
