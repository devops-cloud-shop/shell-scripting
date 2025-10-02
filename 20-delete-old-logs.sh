#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log" #/var/log/shell-scripting/20-delete-old-logs.log

mkdir -p $LOG_FOLDER  # -p creates folder if not exists

echo "Script started execution at : $(date)" | tee -a $LOG_FILE

SOURCE_DIR=/home/ec2-user/shell-scripting/app-logs

if [ ! -d $SOURCE_DIR ]; then
    echo "ERROR:: $SOURCE_DIR does not exists"
    exit 1
fi

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -type f -mtime +14)

while IFS= read -r filepath; 
do
    echo " Deleting the files: $filepath "
done  <<< $FILES_TO_DELETE