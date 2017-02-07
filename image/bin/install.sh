#!/bin/bash

set -o errexit
set -o nounset
set -o xtrace

BUILD="wget ca-certificates"
ESSENTIAL="openjdk-7-jre-headless file libgetopt-long-descriptive-perl"

URL="http://downloads.sourceforge.net/project/ngopt/a5_miseq_linux_${A5_VERSION}.tar.gz"

# Build dependencies
apt-get update --yes
apt-get install --yes --no-install-recommends ${BUILD}

fetch_archive.sh ${URL} a5_miseq
ln -s /usr/local/a5_miseq/bin/* /usr/local/bin/
rm -rf /usr/local/a5_miseq/example

# Clean up dependencies
apt-get autoremove --purge --yes ${BUILD}
apt-get clean

# Install required files
apt-get install --yes --no-install-recommends ${ESSENTIAL}
rm -rf /var/lib/apt/lists/*
