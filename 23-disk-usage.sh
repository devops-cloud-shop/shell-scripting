#!/bin/basah

DISK_USAGE=$(df -hT | grep -v Filesystem)

while IFS= read -r line
do
 echo " Usage $line"
done <<< $DISK_USAGE