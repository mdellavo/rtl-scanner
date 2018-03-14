#!/bin/bash

# set -x 
set -o pipefail

ARGS=3
if [ $# -lt ${ARGS} ]
then
    echo "Usage: `basename $0` LOW HIGH STEP [DURATION]"
    exit 1
fi

LOW="$1"
HIGH="$2"
STEP="$3"
DURATION="$4"

if [ -z ${DURATION} ];
then
    DURATION="10m"
fi

if [ ! -d scans ]; then
    mkdir scans
fi

if [ ! -d scans/archive ]; then
    mkdir scans/archive
fi

mv scans/scan-*.csv.gz scans/archive

trap exit EXIT

echo "[`date`] Scanning ${LOW} -> ${HIGH} with step ${STEP} for ${DURATION} increments..."
while true; do
    STAMP=`date +%Y-%m-%d-%H-%M-%S`
    rtl_power -f ${LOW}:${HIGH}:${STEP} -e ${DURATION} ${ARGS} 2>rtl_power.log |gzip > /tmp/scan.csv.gz
    if [ $? -ne 0 ];
    then
        echo "error running rtl_power"
        echo
        cat rtl_power.log
        exit
    fi;
    mv /tmp/scan.csv.gz scans/scan-${LOW}-${HIGH}-${STAMP}-${DURATION}.csv.gz
done
