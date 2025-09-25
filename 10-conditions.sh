#!/bin/bash

echo "Please enter the number"
read NUMBER

if [$(($NUMBER%2)) -eq 0 ]; then
    echo "The given number $NUMBER is EVEN"
else
    echo "The given number $NUMBER is ODD"
fi

