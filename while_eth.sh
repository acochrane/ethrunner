#!/bin/bash

source /etc/ethrunner/ethrunner.vars

while [[ $(cat $ETHRUNNER_STATUS) = "RUN" ]];
do
    ethminer -U -P stratum1+tcp://$ETHRUNNER_ADDRESS@eth.2miners.com:2020

done
