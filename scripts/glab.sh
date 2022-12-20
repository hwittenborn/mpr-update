#!/usr/bin/env bash
set -e
mpr_version="$(util/get-pkgbuild-version.sh)"
glab_version="$(util/get-latest-glab-version.sh 'gitlab-org/cli')"

if [[ "${glab_version}" != "${mpr_version}" ]]; then
    util/update-pkgbuild-version.sh "${gh_version}"
    util/push-changes.sh
fi