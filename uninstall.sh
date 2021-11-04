#!/bin/bash

# get location of installer
INSTALLER_DIR=$(dirname $(readlink -f $0))

if [ -d /etc/ethrunner ];
then
    rm -rf /etc/ethrunner
fi

rm -rf $INSTALLER_DIR/ethminer
rm $INSTALLER_DIR/ethminer.tar.gz

# remove symlinks
rm /usr/local/bin/ethminer
rm /usr/local/bin/ethminer.sh
rm /usr/local/bin/while_eth.sh
rm /etc/systemd/system/ethminer.service

# refresh service list
#systemctl daemon-reload



