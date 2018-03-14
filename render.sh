#!/bin/bash

#set -x
set -o pipefail

if [ ! -f ./heatmap.py ]; then
    wget https://raw.githubusercontent.com/keenerd/rtl-sdr-misc/master/heatmap/heatmap.py
fi

rsync -avz --delete $HOST:~/scans/scan-*.csv.gz scans/
cat $(ls ./scans/scan-*.csv.gz) | gunzip > /tmp/scan.csv
python ./heatmap.py --palette charolastra /tmp/scan.csv render.png
rm /tmp/scan.csv
open render.png
