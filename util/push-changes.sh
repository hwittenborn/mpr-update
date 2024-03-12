#!/usr/bin/env bash
# Push any changes back to the MPR.
set -e

cd "mpr/${pkgbase}"
pkgver="$(source PKGBUILD; echo "${pkgver}")"
pkgrel="$(source PKGBUILD; echo "${pkgrel}")"

makedeb --print-srcinfo > .SRCINFO

git add .
git commit -m "Bump version to '${pkgver}-${pkgrel}'"
GIT_SSH_COMMAND='ssh -v' git push
