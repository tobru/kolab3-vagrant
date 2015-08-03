#!/usr/bin/env bash
#
# This bootstraps Puppet on Ubuntu
# source: https://github.com/hashicorp/puppet-bootstrap
#
set -e

# Load up the release information
#. /etc/lsb-release
DISTRIB_CODENAME=$(lsb_release -cs)

REPO_DEB_URL="http://apt.puppetlabs.com/puppetlabs-release-${DISTRIB_CODENAME}.deb"

#--------------------------------------------------------------------
# NO TUNABLES BELOW THIS POINT
#--------------------------------------------------------------------
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

#if which puppet > /dev/null 2>&1 -a apt-cache policy | grep --quiet apt.puppetlabs.com; then
if which puppet > /dev/null 2>&1; then
  echo "[INFO $(date +'%H:%M:%S')] Puppet is already installed"
  exit 0
fi

# change sources.list to ch mirror
echo "[INFO $(date +'%H:%M:%S')] Change sources.list to use ch mirror..."
sed -i 's/us.archive/de.archive/g' /etc/apt/sources.list

# Do the initial apt-get update
echo "[INFO $(date +'%H:%M:%S')] Initial apt-get update..."
apt-get update >/dev/null

# Install wget if we have to (some older Ubuntu versions)
echo "[INFO $(date +'%H:%M:%S')] Installing wget..."
apt-get install -y wget >/dev/null

# Install the PuppetLabs repo
echo "[INFO $(date +'%H:%M:%S')] Configuring PuppetLabs repo..."
repo_deb_path=$(mktemp)
wget --output-document="${repo_deb_path}" "${REPO_DEB_URL}" 2>/dev/null
dpkg -i "${repo_deb_path}" >/dev/null
apt-get update >/dev/null

# Install Puppet
echo "[INFO $(date +'%H:%M:%S')] Installing Puppet..."
DEBIAN_FRONTEND=noninteractive apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" install puppet >/dev/null
# remove deprecated config
sed -i '/templatedir/d' /etc/puppet/puppet.conf

echo "[INFO $(date +'%H:%M:%S')] Puppet installed"

# Install RubyGems for the provider
echo "[INFO $(date +'%H:%M:%S')] Installing RubyGems..."
if [ $DISTRIB_CODENAME != "trusty" ]; then
  apt-get install -y rubygems >/dev/null
fi
gem install --no-ri --no-rdoc rubygems-update
update_rubygems >/dev/null

echo "[INFO $(date +'%H:%M:%S')] Shell provisioner finished..."
