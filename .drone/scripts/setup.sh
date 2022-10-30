#!/usr/bin/env bash

# Setup Prebuilt-MPR.
curl -q 'https://proget.makedeb.org/debian-feeds/prebuilt-mpr.pub' | gpg --dearmor | sudo tee /usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg 1> /dev/null
echo "deb [signed-by=/usr/share/keyrings/prebuilt-mpr-archive-keyring.gpg] https://proget.makedeb.org prebuilt-mpr $(lsb_release -cs)" | sudo tee /etc/apt/sources.list.d/prebuilt-mpr.list
sudo apt-get update

# Install needed packages.
sudo apt-get install curl jq git gh -y

# Set up Git.
git config --global user.name 'Kavplex Bot'
git config --global user.email 'kavplex@hunterwittenborn.com'

# Login to GitHub.
echo "${github_api_key}" | gh auth login --with-token

# Setup MPR SSH key.
curl -Ls "https://shlink.${hw_url}/ci-utils" | sudo bash -

mkdir ~/.ssh
echo -e "Host ${mpr_url}\n  Hostname  ${mpr_url}\n  IdentityFile  ${HOME}/.ssh/ssh_key" | tee -a "${HOME}/.ssh/config"
echo "${ssh_key}" | tee "/${HOME}/.ssh/ssh_key"

MPR_SSH_KEY="$(curl "https://${mpr_url}/api/meta" | jq -r '.ssh_key_fingerprints.ECDSA')"

SSH_HOST="${mpr_url}" \
	SSH_EXPECTED_FINGERPRINT="${MPR_SSH_KEY}" \
	SET_PERMS=true \
	get-ssh-key

# Clone the MPR Git repo.
mkdir mpr/
git clone "ssh://mpr@${mpr_url}/${pkgbase}" "mpr/${pkgbase}"