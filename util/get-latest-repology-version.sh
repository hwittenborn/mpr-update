#!/usr/bin/env bash
#
# Get the latest version of a package from Repology.
set -e
curl "https://repology.org/api/v1/project/${1}" | jq -r '[.[] | select(.status=="newest")][0].version'
