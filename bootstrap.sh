#!/usr/bin/env bash

# install some basic tools
apt-get -y install debconf-utils

# http://docs.kolab.org/installation-guide/debian.html
# use the development repository
echo "deb http://obs.kolabsys.com:82/Kolab:/Development/Debian_7.0/ ./" > /etc/apt/sources.list.d/kolab.list
wget -qO - http://obs.kolabsys.com:82/Kolab:/Development/Debian_7.0/Release.key | apt-key add -
cat >/etc/apt/preferences.d/kolab <<EOL
Package: *
Pin: origin obs.kolabsys.com
Pin-Priority: 501
EOL

# https://kolab.org/blog/timotheus-pokorra/2013/11/04/howto-improve-debian-packages-using-obs
echo 'deb http://download.opensuse.org/repositories/openSUSE:Tools/Debian_7.0/ /' > /etc/apt/sources.list.d/osc.list
wget -qO - http://download.opensuse.org/repositories/openSUSE:Tools/Debian_7.0/Release.key | apt-key add -

# preseed package configuration
debconf-set-selections /vagrant/postfix.preseed
debconf-set-selections /vagrant/mysql.preseed

# update apt cache and install the software
apt-get update
aptitude -y install kolab osc build

# refresh clamav
freshclam
/etc/init.d/clamav-daemon start
