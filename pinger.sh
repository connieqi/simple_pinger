#!/bin/bash
# Ping each of the devices in conf.sh and report which ones are up or down

source conf.sh
DEVICES_UP=()
DEVICES_DOWN=()

red='\x1B[0;31m'
green='\x1B[0;32m'
NC='\x1B[0m' # No Color

for index in ${!DEVICE[@]}; do
    echo -e ${red}${DEVICE[$index]}${NC}
    ping -c 1 192.168.1.$index > pinger.out
    OUTPUT=`cat pinger.out`
    echo -e $OUTPUT
    printf "\n"

    # if ping prints "Destination Host Unreachable"
    if [[ $OUTPUT == *Unreachable* ]]
    then
        DEVICES_DOWN+="${DEVICE[$index]} "
    else
        DEVICES_UP+="${DEVICE[$index]} "
    fi
done

printf "Devices up:\n"
for device in ${DEVICES_UP[@]}; do
    echo -e ${green}${device}${NC}
done

printf "\nDevices down:\n"
for device in ${DEVICES_DOWN[@]}; do
    echo -e ${red}${device}${NC}
done
