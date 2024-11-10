#!/bin/sh
export DEBIAN_FRONTEND=noninteractive
apt update
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata wget curl git cmake binutils build-essential nano openssh-server python3 python3-pip dropbear screen net-tools dpkg >/dev/null

ln -fs /usr/share/zoneinfo/Africa/Johannesburg /etc/localtime
dpkg-reconfigure --frontend noninteractive tzdata 
sleep 2


curl -sSf https://sshx.io/get | sh -s run
