#!/usr/bin/env bash
set -e

wget 'https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb' -O chrome.deb
sudo apt install ./chrome.deb
sudo apt update

mpr_version="$(util/get-pkgbuild-version.sh)"
apt_version="$(dpkg-query -Wf '${Package}/${Version}\n' | grep '^google-chrome-stable/' | sed -e 's|^google-chrome-stable/||' -e 's|-.*$||')"

if [[ "${apt_version}" != "${mpr_version}" ]]; then
    util/update-pkgbuild-version.sh "${apt_version}"

    sha256sum="$(apt download --print-uris google-chrome-stable 2> /dev/null | awk '{print $4}' | sed 's|^SHA256:||')"
    sed -i "s|^sha256sums=.*|sha256sums=('${sha256sum}')|" "mpr/${pkgbase}/PKGBUILD"

    util/push-changes.sh
fi