#!/usr/bin/env bash
set -eu
mpr_version="$(util/get-pkgbuild-version.sh)"
glab_version="$(util/get-latest-glab-version.sh 'gitlab-org/cli')"

if [[ "${glab_version}" != "${mpr_version}" ]]; then
    util/update-pkgbuild-version.sh "${glab_version}"
    util/push-changes.sh
fi