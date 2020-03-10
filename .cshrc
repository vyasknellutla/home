#!/usr/bin/env tcsh

# direnv: https://direnv.net/docs/hook.html#bash
if [ -x `command -v direnv` ]; then
    eval `direnv hook tcsh`
fi
