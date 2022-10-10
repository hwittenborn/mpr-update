#!/usr/bin/env bash
# Update the pkgver recorded in the PKGBUILD.
sed -i -e "s|^pkgver=.*|pkgver=${1}|" -e 's|^pkgrel=.*|pkgrel=1|' "mpr/${pkgbase}/PKGBUILD"