# Day 10 Challenge

## Files Created
We have Created 03 file-> 
devOps.txt
notest.txt
script.sh


## Permission Changes
devOps.txt-> before-> -rw-rw-r-- after-> -r--r--r--
notes.txt-> before-> -rw-rw-r-- after-> -rw-r----
script.sh->  before-> -rw-r-r-- after-> -rwxr-xr-x


## Commands Used
Task1
touch devOps.txt
echo "Hello Friend" > notes.txt
vim script.sh-> Insert -> Write content echo "Hello DevOps" -> ecs-> :wq

Task2
cat notes.txt
vim -R script.sh -> for checking readonly-> ecs-> :q-> Enter 
head -n 10 /etc/passwd
tail -n 10 /etc/passwd

Task3
ls -l devops.txt notes.txt script.sh

-rw-rw-r-- 1 ubuntu ubuntu  0 Feb  2 16:14 devOps.txt
-rw-rw-r-- 1 ubuntu ubuntu 21 Feb  2 16:17 notes.txt
-rw-r--r-- 1 ubuntu ubuntu 13 Feb  2 16:18 script.sh

Task4
chmod +x script.sh
chmod 444 devOps.txt
chmod 640 notes.txt
mkdir project
chmod 755 project

ls -l
-r--r--r-- 1 ubuntu ubuntu  0 Feb  2 16:14 devOps.txt
-rw-r----- 1 ubuntu ubuntu 21 Feb  2 16:17 notes.txt
-rwxr-xr-x 1 ubuntu ubuntu 13 Feb  2 16:18 script.sh

ls -ld project

drwxr-xr-x 2 ubuntu ubuntu 4096 Feb  2 16:35 project

Task5

echo "Hi Friend" > devOps.txt -> enter -> Error -> -bash: devOps.txt: Permission denied
chmod -x script.sh
./script.sh -> enter-> error->-bash: ./script.sh: Permission denied


## What I Learned
1-> How to create file 
2-> How to set  permission file and directory
3-> How to excute file with permission.
