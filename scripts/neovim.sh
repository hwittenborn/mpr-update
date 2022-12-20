#!/usr/bin/env bash
set -eu

# We can't use 'util/get-latest-gh-version.sh' due to how Neovim names their releases.
mpr_version="$(util/get-pkgbuild-version.sh)"
gh_version="$(gh release list -R neovim/neovim --exclude-drafts | sed -E 's/^Nvim |^NVIM //' | grep '^v' | awk '{print $1}' | head -n 1 | sed 's|^v||')"

if [[ "${gh_version}" != "${mpr_version}" ]]; then
    util/update-pkgbuild-version.sh "${gh_version}"
    util/push-changes.sh
fi