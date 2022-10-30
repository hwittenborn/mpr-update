#!/usr/bin/env bash
set -e
mpr_version="$(util/get-pkgbuild-version.sh)"
gh_version="$(util/get-latest-gh-version.sh 'harness/drone-cli')"

if [[ "${gh_version}" != "${mpr_version}" ]]; then
    util/update-pkgbuild-version.sh "${gh_version}"
    util/push-changes.sh
fi