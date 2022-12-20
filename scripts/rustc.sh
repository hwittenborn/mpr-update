#!/usr/bin/env bash
set -e
mpr_version="$(util/get-pkgbuild-version.sh)"
gh_version="$(gh release list -R rust-lang/rust | rg Latest | awk '{print $4}')"

if [[ "${gh_version}" != "${mpr_version}" ]]; then
    util/update-pkgbuild-version.sh "${gh_version}"
    util/push-changes.sh
fi