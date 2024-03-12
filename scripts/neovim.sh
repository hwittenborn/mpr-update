#!/usr/bin/env bash
set -eu

# We can't use 'util/get-latest-gh-version.sh' due to how Neovim names their releases.
mpr_version="$(util/get-pkgbuild-version.sh)"
gh_version="$(util/get-latest-gh-version.sh 'neovim/neovim')"

if [[ "${gh_version}" != "${mpr_version}" ]]; then
    util/update-pkgbuild-version.sh "${gh_version}"
    util/push-changes.sh
fi
