#!/usr/bin/env bash
# Get the latest release version of a repo from GitHub.
set -e
gh api "repos/${1}/releases" -q '[.[] | select(.prerelease==false)][0].tag_name' | grep '[0-9]' | head -n 1 | sed 's|^v||'
