#Day 20 task- Bash Scripting Challenge: Log Analyzer and Report Generator

```
#!/bin/bash

set -euo pipefail

<<Task

You are a system administrator responsible for managing a network of servers. Every day, a log file is
generated on each server containing important system events and error messages. Your job is to analyze
hese log files, identify specific events, and generate a summary report.

Task

if [ "$#" -eq 0 ]
then
	echo "Usage:$0  Please enter  <path of log file>"
	exit 1
fi

if [ ! -f "$1" ]
then
	echo "Error: $1 doesn't exist in directory. Please check log file name"
	exit 1
fi


ERROR_COUNT=$(grep -c "ERROR" $1)

echo "Total Error Count: $ERROR_COUNT"


CRITICAL_SEARCH=$(grep -n "CRITICAL" $1)

echo "$CRITICAL_SEARCH"


TOP_ERROR=$(grep "ERROR" $1 | awk -F'] ' '{print $2}' | awk -F' - ' '{print $1}' | sort | uniq -c | sort -rn | head -5)

echo "----------------------TOP 5 ERROR MESSAGE------------------------"
echo ""

echo "$TOP_ERROR"


# Generate Summary report:


DATE=$(date +"%Y-%m-%d")

LOG_FILE="log_report_$DATE.txt"

echo "Total Line Procesed: $(wc -l < "$LOG_FILE")"

{
	echo "Date of analysis : $DATE"
	echo "Log file name    : $LOG_FILE"
	echo "Total lines processed : $(wc -l < $1)"
	echo "Total error count : $ERROR_COUNT"
	echo "Top 5 error messages with their occurrence count:" 

	echo "$TOP_ERROR"

	echo "List of critical events with line numbers:"

	echo "$CRITICAL_SEARCH"

} > "$LOG_FILE"

 echo "Report generated successfully: $LOG_FILE"
