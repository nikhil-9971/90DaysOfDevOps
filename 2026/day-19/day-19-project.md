# Day 19 – Shell Scripting Project: Log Rotation, Backup & Crontab
```

#Task 1: Log Rotation Script

#!/bin/bash

set -euo pipefail

<<'DISCLAIMER'

This is a log rotation script

DISCLAIMER





#if count of argument is equal to zero then error display

if [ $# -eq 0 ] 
then
	echo "Usage:$0 <path of directory>"
	exit 1
fi

#check directory doesn't exists

if [ ! -d "$1" ]
then 
	echo "Error: Your mentioned $1  directory not available"
	exit 1
fi

LOG_DIR="$1"

#function made for compress log file after 7 days ago


function compress_log_file(){

    count=$(find "$LOG_DIR" -type f -name "*.log" -mtime +7 | wc -l)

    if [ "$count" -eq 0 ]
    then
        echo "No .log files older than 7 days found."
    else
        find "$LOG_DIR" -type f -name "*.log" -mtime +7 -exec gzip {} \;
        echo "$count file(s) compressed."
    fi
}

#function made for delete .gz compress file after 30 days

function delete_file(){

	count=$(find "$LOG_DIR" -type f -name "*.gz" -mtime +30 | wc -l)

	if [ "$count" -eq 0 ]
	then
		echo "No .gz files older than 30 days found"
	else
		find "$LOG_DIR" -type f -name "*.gz" -mtime +30 -exec rm -f {} \;
		echo "$count .gz file(s) deleted"
	fi
}

compress_log_file
delete_file


#Task 2: Server Backup Script

#!/bin/bash

set -euo pipefail

<< readme

This script is use for taking backup of
source directory

readme


function display_usage() {
	echo "Usage: ./backup.sh <path to your source> <path to backup folder"
}

if [ $# -eq 0 ]
then
	display_usage
	exit 1
fi

source_path=$1
timestamp=$(date +%Y-%m-%d_%H-%M-%S)
backup_path=$2

#Validate Source directory

if [ ! -d "$source_path" ]
then
    echo  "Error: Source directory does not exist!"
    exit 1
fi

function create_backup(){

	tar -czf "${backup_path}/backup-${timestamp}.tar.gz" "${source_path}"
	echo "Backup created successfully for $timestamp"
}



function size_name_backupfile(){
	backup_file="${backup_path}/backup-${timestamp}.tar.gz"
	if [ -f "$backup_file" ]
	then
		echo "Backup file Name: $(basename "$backup_file")"
		echo "Backup file size: $(du -h "$backup_file" | cut -f1)"
	fi
}

function delete_14dayafter(){
	

	count=$(find "$backup_path" -type f -name "*.tar.gz" -mtime +14 | wc -l)

	if [ $count -eq 0 ]
	then
		echo " No .tar.gz files older than 14 days "
	else 
		find "$backup_path" -type f -name "*.tar.gz" -mtime +14 -exec rm -f {} \;
		echo "$count .tar.gz file(s) deleted"
	fi
}

create_backup
size_name_backupfile
delete_14dayafter


#Task 3: Crontab

 Edit this file to introduce tasks to be run by cron.
# 
# Each task to run has to be defined through a single line
# indicating with different fields when the task will be run
# and what command to run for the task
# 
# To define the time you can provide concrete values for
# minute (m), hour (h), day of month (dom), month (mon),
# and day of week (dow) or use '*' in these fields (for 'any').
# 
# Notice that tasks will be started based on the cron's system
# daemon's notion of time and timezones.
# 
# Output of the crontab jobs (including errors) is sent through
# email to the user the crontab file belongs to (unless redirected).
# 
# For example, you can run a backup of all your user accounts
# at 5 a.m every week with:
# 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
# 
# For more information see the manual pages of crontab(5) and cron(8)
# 
# m h  dom mon dow   command

00 2 * * * bash /home/ubuntu/day19/log_rotate.sh /home/ubuntu/day19
00 3 * * 7 bash /home/ubuntu/day19/backup.sh /home/ubuntu/day19/source_dir /home/ubuntu/day19/backup_dir
00 1 * * * bash /home/ubuntu/day19/maintenance.sh

~                                                         

#Task 4: Combine — Scheduled Maintenance Script

#!/bin/bash


set -euo pipefail

LOG_FILE="/home/ubuntu/day19/maintenance.log"
SOURCE_DIR="/home/ubuntu/day19/source_dir"
BACKUP_DIR="/home/ubuntu/day19/backup_dir"
DAY19_DIR="/home/ubuntu/day19"

function log_message() {
         echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" 
}

{
    echo "===== Maintenance Started ====="
    echo "     "

    # Call log rotation script
    log_message "Running log rotation..."
    ./log_rotate.sh "$DAY19_DIR" 

    # Call backup script
    log_message "Running backup..."
    ./backup.sh "$SOURCE_DIR" "$BACKUP_DIR"

    echo "      "
    echo "===== Maintenance Completed ====="

} >> "$LOG_FILE" 2>&1

