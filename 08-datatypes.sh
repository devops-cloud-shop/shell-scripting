#!/bin/bash

NUMBER1=100
NUMBER2=200

SUM=$(($NUMBER1+$NUMBER2))

echo "SUM is : $SUM"


#List and using index

# Size = 4, Max index = 3
LEADERS=("Modi" "Putin" "Trudo" "Trump")

echo "All leaders: ${LEADERS[@]}"
echo "First Leader: ${LEADERS[0]}"
echo "Second Leader: ${LEADERS[1]}"