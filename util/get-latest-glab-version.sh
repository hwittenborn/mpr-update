#!/usr/bin/env bash
# Get the latest release version of a repo from GitHub.
set -e
glab release ls -R "${1}" | head -n -1 | tac | head -n -2 | tac | awk '{print $1}' | sed 's|^v||' | head -1