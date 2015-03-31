#!/bin/bash



set -x

sudo apt-get purge -y python.*

sudo sed -i -e 's/archive\.ubuntu\.com/cn-north-1a.clouds.archive.ubuntu.com/g' /etc/apt/sources.list

set +x
