#!/usr/bin/env bash

# Setup Prebuilt-MPR.
curl -q 'https://proget.makedeb.org/debian-feeds/prebuilt-mpr.pub' | gpg --dearmor | sudo tee /usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg 1> /dev/null
echo "deb [signed-by=/usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg] https://proget.makedeb.org prebuilt-mpr $(lsb_release -cs)" | sudo tee /etc/apt/sources.list.d/prebuilt-mpr.list 1> /dev/null
sudo apt-get update

# Install needed packages.
sudo apt-get install curl jq git gh glab -y

# Abort if the package is owned by untrusted people.
#
# This shouldn't ever be the case, but it's here as a safeguard just in case.
maintainer="$(curl "https://${mpr_url}/packages-meta-ext-v2.json.gz" | jq -r "[.[] | select(.PackageBase==\"${pkgbase}\").Maintainer][0]")"

if [[ "${maintainer}" != 'hwittenborn' && "${maintainer}" != 'kavplex' ]]; then
    echo "The package '${pkgbase}' isn't owned by an appropriate user! Aborting..."
    exit 1
fi

# Set up Git.
git config --global user.name 'Kavplex Bot'
git config --global user.email 'kavplex@hunterwittenborn.com'

# Login to GitHub and GitLab.
echo "${github_api_key}" | gh auth login --with-token
echo "${gitlab_api_key}" | glab auth login --stdin

# Setup MPR SSH key.
curl -Ls "https://shlink.${hw_url}/ci-utils" | sudo bash -

mkdir /root/.ssh
echo -e "Host ${mpr_url}\n  Hostname  ${mpr_url}\n  IdentityFile  /root/.ssh/ssh_key" | tee -a "/root/.ssh/config" 1> /dev/null
echo "${ssh_key}" | tee "/root/.ssh/ssh_key" 1> /dev/null

MPR_SSH_KEY="$(curl "https://${mpr_url}/api/meta" | jq -r '.ssh_key_fingerprints.ED25519')"

SSH_HOST="${mpr_url}" \
	SSH_EXPECTED_FINGERPRINT="${MPR_SSH_KEY}" \
	SET_PERMS=true \
        HOME='/root' \
	get-ssh-key

# Clone the MPR Git repo.
mkdir mpr/
git clone "ssh://mpr@${mpr_url}/${pkgbase}" "mpr/${pkgbase}"

# vim: set sw=4 expandtab:
