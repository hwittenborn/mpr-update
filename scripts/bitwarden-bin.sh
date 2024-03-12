#!/usr/bin/env bash
set -eu
mpr_version="$(util/get-pkgbuild-version.sh)"
repology_version="$(util/get-latest-repology-version.sh 'bitwarden')"

if [[ "${repology_version}" != "${mpr_version}" ]]; then
    util/update-pkgbuild-version.sh "${repology_version}"
    util/push-changes.sh
fi
