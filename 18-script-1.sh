#!/bin/bash

NAME=INDIA

echo "My county is $NAME"
echo "PID of script-1: $$"
#sh 19-script-2.sh

# here we are accessing script 2

source ./19-script-2.sh # source command searches the file in the path, here it is current dir (.)