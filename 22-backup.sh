#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} #if not provided dynamically while executing the script-it considers 14 days as default

LOG_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log" #/var/log/shell-scripting/20-delete-old-logs.log

mkdir -p $LOG_FOLDER  # -p creates folder if not exists

echo "Script started execution at : $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]; then  # execute the script with root priviledges
    echo "ERROR:: execute the script with root priviledges"
    exit 1
fi

USAGE(){
    echo -e " $R USAGE:: sudo sh 22-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS>[optional, default 14 days]$N"
    exit 1
}

if [ $# -lt 2 ]; then #while executing the script you need to pass the args dynamically
    USAGE
fi

#check if source-dir and dest-dir exists or not

if [ ! -d $SOURCE_DIR ]; then
    echo -e "$R Source $SOURCE_DIR does not exists $N"
fi

if [ ! -d $DEST_DIR ]; then
    echo -e "$R Destination $DEST_DIR does not exists $N"
fi

OLD_FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

if [ ! -z "${OLD_FILES}" ]; then # -z is to check if the var has files in it to archive/zip
#if empty- files are already zipped/archives, if not,then we need to perform next steps.
    echo "Files found $OLD_FILES"
    TIMESTAMP=$(date +%F-%H-%M)
    ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    echo "zip file name: $ZIP_FILE_NAME"
    find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS | zip -@ -j "$ZIP_FILE_NAME" # -j is used bcoz when unzipped
    # you want to see only zip file names or else you will see the path along with the file name.

### Check Archieval Success or not ###
    if [ -f $ZIP_FILE_NAME ]
    then
        echo -e "Archeival ... $G SUCCESS $N"

        ### Delete if success ###
        while IFS= read -r filepath
        do
            echo "Deleting the file: $filepath"
            rm -rf $filepath
            echo "Deleted the file: $filepath"
        done <<< $OLD_FILES
    else
        echo -e "Archieval ... $R FAILURE $N"
        exit 1
    fi
    
else
    echo -e "No files to archeive ... $Y SKIPPING $N"
fi