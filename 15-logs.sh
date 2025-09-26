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

dnf list installed mysql &>>$LOG_FILE #checking if package already installed or not 
                                      #and redirecting the output to log_file

if [ $? -ne 0 ]; then    #if the exit code is not zero i.e., package not found -so we install it
    dnf install mysql -y &>>$LOG_FILE
    VALIDATE $? "MySQL" #here we are calling the function and fuct receives/treats inputs as args
                        #hence we have replaced $? as $1 and MySQL as $2
else
    echo -e "MySQL already exist... $Y SKIPPING $N" | tee -a $LOG_FILE #-e to enable color code 
fi

dnf list installed nginx &>>$LOG_FILE

if [ $? -ne 0 ]; then
    dnf install nginx -y &>>$LOG_FILE
    VALIDATE $? "nginx"
else 
    echo -e "nginx alredy exist... $Y SKIPPING $N" | tee -a $LOG_FILE
fi

dnf list installed python3 &>>$LOG_FILE

if [ $? -ne 0 ]; then
    dnf install python3 -y &>>$LOG_FILE
    VALIDATE $? "python3"
else 
    echo -e "Python3 already exists... $Y SKIPPING $N" | tee -a $LOG_FILE
fi
