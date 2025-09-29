#!/bin/bash

set -e   #exit the script when error occurs

trap 'echo "There is an error in $LINENO, Command is: $BASH_COMMAND"' ERR

echo "Hello"
echo "Before error"
frtkd-scmd/; # Here shell script understands there is an error and signals as ERR
echo "After error"


