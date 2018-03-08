#!/bin/bash

# set -x 

LOW="24M"
HIGH="1700M"
STEP="125k"
DURATION="10m"

OPTS="-i 100 -g 50"

while true; do
    NOW=`date`
    STAMP=`date +%Y%m%d%H%M%S`
    echo "[${NOW}] Scanning ${LOW} -> ${HIGH} with step ${STEP} for ${DURATION}..."
    rtl_power -f ${LOW}:${HIGH}:${STEP} -e ${DURATION} ${OPS} 2>rtl_power.log |gzip >./scans/tmp.csv.gz
    mv ./scans/tmp.csv.gz ./scans/scan-${LOW}-${HIGH}-${STAMP}.csv.gz
done
