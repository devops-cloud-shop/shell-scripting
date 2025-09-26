#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo -e "Installing ... $R FAILURE $N"
echo -e "Installation ... $G SUCCESS $N"
echo -e "Package already exists ... $Y SKIPPING $N"
echo "checking the colors"