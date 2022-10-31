#!/usr/bin/env bash
# Get the hash of an APT package.
apt download --print-uris "${1}" 2> /dev/null | awk '{print $4}'