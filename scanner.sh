#!/bin/bash

# set -x 
set -o pipefail

if [ $# -lt 3 ]
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

if [ ! -d scans/archive ]; then
    mkdir -p scans/archive
fi

mv -f scans/scan-*.csv.gz scans/archive

trap exit EXIT

echo "[`date`] Scanning ${LOW} -> ${HIGH} with step ${STEP} for ${DURATION} increments (ARGS=${ARGS})..."
while true; do
    STAMP=`date +%Y-%m-%d-%H-%M-%S`
    rtl_power -f ${LOW}:${HIGH}:${STEP} -e ${DURATION} ${ARGS} |gzip > /tmp/scan.csv.gz
    mv /tmp/scan.csv.gz scans/scan-${LOW}-${HIGH}-${STAMP}-${DURATION}.csv.gz
done
