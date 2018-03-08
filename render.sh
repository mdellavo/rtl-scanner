#!/bin/bash

#set -x

cat $(ls ./scans/scan-*.csv.gz) | gunzip > /tmp/scan.csv
python ./heatmap.py /tmp/scan.csv render.png
rm /tmp/scan.csv
