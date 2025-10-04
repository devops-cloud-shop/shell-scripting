#!/bin/basah

DISK_USAGE=$(df -hT | grep -v Filesystem)

while IFS= read -r line
do

done <<< $DISK_USAGE