#!/bin/bash

#set -x

rsync -avz $HOST:~/scans/scan* scans/
cat $(ls ./scans/scan-*.csv.gz) | gunzip > /tmp/scan.csv
python ./heatmap.py /tmp/scan.csv render.png
rm /tmp/scan.csv
open render.png
