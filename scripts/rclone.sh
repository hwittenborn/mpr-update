#!/usr/bin/env bash
set -eu
mpr_version="$(util/get-pkgbuild-version.sh)"
gh_version="$(util/get-latest-gh-version.sh 'rclone/rclone')"
sha256sum="$(util/get-gh-source-code-hash.sh 'rclone/rclone' "v${gh_version}")"

if [[ "${gh_version}" != "${mpr_version}" ]]; then
    util/update-pkgbuild-version.sh "${gh_version}"
    sed -i "s|^sha256sums=.*|sha256sums=('${sha256sum}')|" "mpr/${pkgbase}/PKGBUILD"
    util/push-changes.sh
fi
