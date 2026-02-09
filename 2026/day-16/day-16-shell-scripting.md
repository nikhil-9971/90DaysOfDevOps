```
Day 16 – Shell Scripting Basics

Task1:

#!/bin/bash


echo "Hello, DevOps!"

Task2:

#!/bin/bash


NAME="NIKHIL"
ROLE="DevOps Engineer"


echo "Hello, I am $NAME and I am a $ROLE."

Task3:

#!/bin/bash

read -p "Enter your Name: " NAME
read -p "Enter your favourite tool: " TOOL


echo "Hello $NAME, your favourite tool is $TOOL"

Task4(a):

#!/bin/bash

read -p "Enter Number: " NUMBER

if [ $NUMBER -gt 0 ]
then
        echo "It is positive number"
elif [ $NUMBER -lt 0 ]
then
        echo "It is negative number"
else
        echo "It is a Zero"
fi



Task4(b):

#!/bin/bash


read -p "Enter file Name: " FILE

if [ -f $FILE ]
then
        echo "This file $FILE is available"
else
        echo "This file $FILE isn't available"
fi

Task5:

#!/bin/bash


read -p "Enter Service name: " service
read -p "Do you want to check the status?(y/n): " status

if [ $status = "y" ]
then
        sudo systemctl status $service
        echo "This service is Active"
else
        echo "Skipped."
fi

