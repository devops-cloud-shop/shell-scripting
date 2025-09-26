#!/bin/bash

USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

if [ $USERID -ne 0 ]; then #checking if the user is root or not
    echo "ERROR:: Please execute the script with root priviledges"
    exit 1
fi

VALIDATE(){                
if [ $1 -ne 0 ]; then 
    echo -e "ERROR:: Installating $2 ... $R FAILURE $N"
    exit 1
else
    echo -e "Installation of $2...$G SUCCESS $N"
fi
}

dnf list installed mysql #checking if package already installed or not

if [ $? -ne 0 ]; then    #if the exit code is not zero i.e., package not found -so we install it
    dnf install mysql -y
    VALIDATE $? "MySQL" #here we are calling the function and fuct receives/treats inputs as args
                        #hence we have replaced $? as $1 and MySQL as $2
else
    echo -e "MySQL already exist... $Y SKIPPING $N"  #-e to enable color code 
fi

dnf list installed nginx 

if [ $? -ne 0 ]; then
    dnf install nginx -y
    VALIDATE $? "nginx"
else 
    echo -e "nginx alredy exist... $Y SKIPPING $N"
fi

dnf list installed python3

if [ $? -ne 0 ]; then
    dnf install python3 -y
    VALIDATE $? "python3"
else 
    echo "Python3 already exists... $Y SKIPPING $N"
fi
