#!/usr/bin/env bash
set -eu
mpr_version="$(util/get-pkgbuild-version.sh)"
gh_version="$(util/get-latest-gh-version.sh 'bats-core/bats-core')"

if [[ "${gh_version}" != "${mpr_version}" ]]; then
    util/update-pkgbuild-version.sh "${gh_version}"
    util/push-changes.sh
fi