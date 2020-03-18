#!/bin/sh

## TODO surround with "if macOS" conditional
if [ "$(uname -s)" = "Darwin" ]; then # Check if using macOS
    sudo dscacheutil -flushcache
    sudo killall -HUP mDNSResponder
    say cache flushed
elif [ "$(uname -s)" = "Linux" ]; then
    sudo /etc/init.d/dns-clean restart
    sudo /etc/init.d/networking force-reload
fi
