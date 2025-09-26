#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then #checking if the user is root or not
    echo "ERROR:: Please execute the script with root priviledges"
    exit 1
fi

VALIDATE(){                
if [ $1 -ne 0 ]; then 
    echo "ERROR:: Installating $2 is a failure"
    exit 1
else
    echo "Installation of $2 is SUCCESS"
fi
}

dnf install mysql -y
VALIDATE $? "MySQL" #here we are calling the function and fuct receives/treats inputs as args
#hence we have replaced $? as $1 and MySQL as $2

dnf install nginx -y
VALIDATE $? "nginx"

dnf install python3 -y
VALIDATE $? "python3"