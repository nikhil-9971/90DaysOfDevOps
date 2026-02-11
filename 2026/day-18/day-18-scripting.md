# Day 18 – Shell Scripting: Functions & Slightly Advanced Concepts
```

Task1-

File Name-functions.sh

#!/bin/bash


function greet(){
echo "Hello, $1!"
}
greet "$1"

function add(){

a="10"
b="12"

echo "Addition of 02 number is: $((a + b))"
}
add

Task2-

File Name-disk_check.sh

#!/bin/bash

function check_disk(){

        df -h | awk 'NR==2 {print $3}'

}


function check_memory(){

       free -h | awk 'NR==2 {print $7}'
}



echo "-----------------------------SYSTEM INFORMATION--------------------------------"

echo "Total Memory Used in server: "
check_disk
echo "Total Memory available: "
check_memory


echo "-----------------------------END-----------------------------------------------"

Task3 

File Name :- strict_demo.sh

#!/bin/bash


set -euo pipefail

echo "---------------------------------Strict Mode----------------------------------------"

echo "Hello, Good Morning ! $name"

mkdir /root/devops-test

cat hello.txt | echo "File not found"

echo "Script Sucessfully completed"

Document: What does each flag do?

- Set -e-> Exit immediately if a command fails (non-zero exit status).
- Set -u -> Treat unset (undefined) variables as an error.
- Set -o pipefail -> If any command in a pipeline fails, the entire pipeline fails.

Default behavior:
Sirf last command ka status check hota hai

With pipefail:
Pipeline ke kisi bhi command me failure → script exit

Task4-

File Name-local_demo.sh

#!/bin/bash


echo "------------------------------------Use Local Keyword---------------------------------------"

function local_keyword(){

        local name="Nikhil"
        echo "Inside Function: $name"
}

local_keyword

echo "Outside function: $name"


echo "--------------------------------Without Local Keyword---------------------------------------"

function global_keyword(){

        name="Advit"
        echo "Inside Fuction: $name"
}

global_keyword

echo "Outside function: $name"


Task5-

File Name- system_info.sh


#!/bin/bash


set -euo pipefail

function hostname_os(){
        local host=$(hostname)
        local os=$(uname -a)
        echo "Hostname: $host"
        echo "OS Name: $os"
}

function device_uptime(){
        local device_uptime=$(uptime)
        echo "Uptime: $device_uptime"
}


function top_disk_usage(){
        echo "Top 05 disk usage by size: "
        df -h | sort -k5 -hr | head -n 5

}

function memory_usage(){
        echo "Memory Usage: "
        free -h
}


function top_cpu_consuming(){
        echo "Top 5 CPU Consuming Process: "
        ps -eo user,pid,comm,%cpu --sort=-%cpu | head -n 6

}


function main_system_info(){

        echo "---------------------------------System Info Reporter------------------------------"
        hostname_os
        device_uptime
        top_disk_usage
        memory_usage
        top_cpu_consuming
        echo "---------------------------------END----------------------------------------------"
}

main_system_info

What I Learned

- How to use function
- How to local Keyword
- set -euo pipefail - How to use this command and why -> If any command in a pipeline fails, the entire pipeline fails.




