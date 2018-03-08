#!/bin/bash

#set -x

cat $(ls ./scans/scan-*.csv.gz) | gunzip > scan.csv
python ./heatmap.py scan.csv scan-`date +%Y%m%d%H%M%S`.png
rm scan.csv
