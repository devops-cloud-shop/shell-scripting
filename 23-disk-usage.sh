#!/bin/basah

DISK_USAGE=$(df -hT | grep -v Filesystem)
DISK_THRESHOLD=2 #In project we keep the value as 75-80
MESSAGE=""

while IFS= read -r line
do
    USAGE=$(echo $line | awk '{print $6}' | cut -d "%" -f1)
    PARTITION=$( echo $line | awk '{print $7}')
    if [ $USAGE -ge $DISK_THRESHOLD ]; then
        MESSAGE+="High disk usage on $PARTITION: $USAGE %"
    fi
 
done <<< $DISK_USAGE

echo -e "Message Body: $MESSAGE"