#!/usr/bin/bash
# Get the SHA256 hash from the 'tar.gz' archive of a project's source code.
gh release download -R "${1}" "${2}" -A tar.gz -O - | sha256sum | awk '{print $1}'
