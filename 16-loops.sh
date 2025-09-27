#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOG_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log" #/var/log/shell-script/15-logs.log

mkdir -p $LOG_FOLDER  # -p creates folder if not exists

echo "Script started execution at : $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]; then #checking if the user is root or not
    echo "ERROR:: Please execute the script with root priviledges"
    exit 1
fi

VALIDATE(){                
if [ $1 -ne 0 ]; then 
    echo -e "ERROR:: Installating $2 ... $R FAILURE $N" | tee -a $LOG_FILE
    exit 1
else
    echo -e "Installation of $2...$G SUCCESS $N" | tee -a $LOG_FILE
fi
}

for package in $@
do

    dnf list installed $package &>>LOG_FILE
    if [ $? -ne 0 ]; then
    dnf install $package -y &>>LOG_FILE
    VALIDATE $? "$package"
    else
    echo -e "Package already installed... $Y SKIPPING $N"
    fi
done