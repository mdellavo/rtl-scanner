#!/bin/bash

# set -x 

LOW="24M"
HIGH="1700M"
STEP="125k"
DURATION="10m"

OPTS=""

while true; do
    NOW=`date`
    STAMP=`date +%Y%m%d%H%M%S`
    echo "[${NOW}] Scanning ${LOW} -> ${HIGH} with step ${STEP} for ${DURATION}..."
    rtl_power -f ${LOW}:${HIGH}:${STEP} -e ${DURATION} ${OPS} 2>rtl_power.log |gzip > /tmp/scan.csv.gz
    mv /tmp/scan.csv.gz ./scans/scan-${LOW}-${HIGH}-${STAMP}.csv.gz
done
