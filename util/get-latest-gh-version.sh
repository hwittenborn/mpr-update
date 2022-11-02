#!/usr/bin/env bash
# Get the latest release version of a repo from GitHub.
set -e
gh release list -R "${1}" --exclude-drafts | grep -v 'Pre-release' | head -n 1 | awk '{print $1}' | sed 's|^v||'