```
Day 17 – Shell Scripting: Loops, Arguments & Error Handling

Task1-

#!/bin/bash
list="mango apple banana guava grapes"
for item in $list
do
        echo "$item"
done

Task2-

File Name- countdown.sh

#!/bin/bash

read -p "Enter the number: " num

while [ $num -ge 0 ]
do
        echo "$num"
        num=$((num-1))
done
echo "Done!"



Task3(a)-

File Name-greet.sh

#!/bin/bash


if [ $1 ]
then
        echo "Hello, $1!"
else
        echo "Usage:./greet.sh"
fi

Task3(b)-

File name- args_demo.sh

#!/bin/bash


echo "Total Number of Arguments: $#"
echo "All Argument: $@"
echo "script Name: $0"


Task4-

File name- install_packages.sh

#!/bin/bash


packages="nginx curl wget"

sudo apt update -y

for item in $packages
do
        if dpkg -s "$item" >/dev/null 2>&1
        then
                echo "$item is  already install"
                continue
        else
                sudo apt install -y $item
                echo "$item installed sucessfully"
        fi
done

Task5-

File name- safe_script.sh

#!/bin/bash


set -e

mkdir /tmp/devops-test || echo "Message: Directory already exists"

cd /tmp/devops-test || echo " Message: Unable to move in directory"

touch text.txt || echo "Message: failed to create file"

echo "Script run successfully"


What I Learned:


Loop structures in Bash
Script arguments & positional parameters
Package validation before installation
Error handling using set -e and ||
