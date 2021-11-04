#!/bin/bash

# get location of installer
INSTALLER_DIR=$(dirname $(readlink -f $0))

if [ ! -d /etc/ethrunner ];
then
    mkdir /etc/ethrunner
fi

if [ ! -d /usr/local/bin ];
then
    mkdir /usr/local/bin
fi

cd $INSTALLER_DIR
$($(cat wget_ethminer.cmd))
tar -xf ethminer.tar.gz
cd -

# put symlinks in
ln -s $INSTALLER_DIR/bin/ethminer /usr/local/bin/ethminer
ln -s $INSTALLER_DIR/ethrunner.vars /etc/ethrunner/ethrunner.vars
ln -s $INSTALLER_DIR/ethminer.sh /usr/local/bin/ethminer.sh
ln -s $INSTALLER_DIR/while_eth.sh /usr/local/bin/while_eth.sh
# make a cp to systemd
cp -a $INSTALLER_DIR/ethminer.service /etc/systemd/system/ethminer.service

# refresh service list
systemctl daemon-reload

systemctl enable ethminer


