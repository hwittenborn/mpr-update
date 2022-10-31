#!/usr/bin/env bash
# Update the pkgrel recorded in the PKGBUILD.
declare -i current_pkgrel="$(source "mpr/${pkgbase}/PKGBUILD"; echo "${pkgrel}")"
current_pkgrel+=1

sed -i "s|^pkgrel=.*|pkgrel=${current_pkgrel}|" "mpr/${pkgbase}/PKGBUILD"