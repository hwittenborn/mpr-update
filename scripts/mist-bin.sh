#!/usr/bin/env bash
set -eu

set_pbmpr_distro() {
    echo "deb [signed-by=/usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg] https://proget.makedeb.org prebuilt-mpr ${1}" | sudo tee /etc/apt/sources.list.d/prebuilt-mpr.list
    sudo apt update
}

mpr_version="$(util/get-pkgbuild-version.sh)"
gh_version="$(util/get-latest-gh-version.sh 'makedeb/mist')"

for distro in focal jammy bullseye; do
    set_pbmpr_distro "${distro}"
    hash="$(util/get-apt-hash.sh mist | sed 's|^SHA512:||')"
    sed -i "s|^${distro}_sha512sums=.*|${distro}_sha512sums=('${hash}')|" "mpr/${pkgbase}/PKGBUILD"
done

if [[ "${gh_version}" != "${mpr_version}" ]]; then
    util/update-pkgbuild-version.sh "${gh_version}"
    util/push-changes.sh
elif [[ "$(cd "mpr/${pkgbase}"; git diff)" != '' ]]; then
    util/bump-pkgbuild-pkgrel.sh
    util/push-changes.sh
fi
