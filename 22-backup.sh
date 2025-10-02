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

if [ $USERID -ne 0 ]; then
    echo "ERROR:: execute the script with root priviledges"
    exit 1
fi

USAGE(){
    echo -e " $R USAGE:: sudo sh 22-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS>[optional, default 14 days]$N"
    exit 1
}

if [ $# -lt 2 ]; then
    USAGE
fi
