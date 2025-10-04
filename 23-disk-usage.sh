#!/bin/basah

DISK_USAGE=$(df -hT | grep -v Filesystem)
DISK_THRESHOLD=2 #In project we keep the value as 75-80
IP_ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)  # -s: silent- to avoid unnecessary log in the result
MESSAGE=""

while IFS= read -r line
do
    USAGE=$(echo $line | awk '{print $6}' | cut -d "%" -f1)
    PARTITION=$( echo $line | awk '{print $7}')
    if [ $USAGE -ge $DISK_THRESHOLD ]; then
        MESSAGE+="High disk usage on $PARTITION: $USAGE % <br> " #\n is used to format the result message
    fi                                                       #<br> if it is html message
    
 
done <<< $DISK_USAGE

echo -e "Message Body: $MESSAGE" # here -e is used to treat \n as a special character

sh mail.sh "pravs.officl@gmail.com" "High Disk Usage Alert" "High Disk Usage" "$MESSAGE" "$IP_ADDRESS" "DevOps Team"

# TO_ADDRESS=$1
# SUBJECT=$2
# ALERT_TYPE=$3
# MESSAGE_BODY=$4
# IP_ADDRESS=$5
# TO_TEAM=$6