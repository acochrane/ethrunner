#!/bin/bash

echo RUN > mine.status

while [[ $(cat mine.status) = "RUN" ]];
do
	/home/acochrane/src/ethminer/bin/ethminer -U -P stratum1+tcp://0x84b53a1a899c017e66b1f210b2b050af317d071d@eth.2miners.com:2020
done
