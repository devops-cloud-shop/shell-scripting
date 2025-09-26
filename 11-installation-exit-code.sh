#!/bin/bash

USERID=$(id -u)

if [ $USERID -ne 0 ]; then   #checking if the user has root access - root userid is 0

    echo "ERROR:: Please run the script with root priviledges"
    exit 1    #if the user is not a root user the script should exit and not proceed further- hence we write exit status

fi

dnf install mysqlde -y

if [ $? -ne 0 ]; then

    echo "ERROR:: Installating MySQL is failure"
    exit 1
else
    echo "Installation of MySQL is SUCCESS"
fi
