#!/usr/bin/env bash
# Get the pkgver recorded in the PKGBUILD.
set -e
source "mpr/${pkgbase}/PKGBUILD"
echo "${pkgver}"