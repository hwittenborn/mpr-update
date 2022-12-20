#!/usr/bin/env bash
set -eu
mpr_version="$(util/get-pkgbuild-version.sh)"

pushd "$(mktemp -d)"
git clone --depth 1 --no-single-branch "https://${github_url}/golang/go"
cd go/
latest_version="$(git tag | sort -V | grep -v '^release|^weekly|rc|beta' | tac | head -1 | sed 's|^go||')"
popd

if [[ "${latest_version}" != "${mpr_version}" ]]; then
    util/update-pkgbuild-version.sh "${latest_version}"
    util/push-changes.sh
fi