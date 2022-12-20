#!/usr/bin/env bash
set -e
mpr_version="$(util/get-pkgbuild-version.sh)"

pushd "$(mktemp -d)"
git clone --depth 1 --no-single-branch "https://${github_url}/golang/go"
latest_version="$(git tag | sort -V | rg -v '^release|^weekly|rc|beta' | tac | head -1 | sed 's|^go||')"

if [[ "${latest_version}" != "${mpr_version}" ]]; then
    util/update-pkgbuild-version.sh "${latest_version}"
    util/push-changes.sh
fi