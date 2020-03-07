#!/usr/bin/env sh

## TODO surround with "if macOS" conditional
sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder
say cache flushed
