#  Shell Scripting Cheat Sheet (DevOps Reference)

> Har concept ko 1 line me: kya karta hai + kaise use hota hai.

---

## ⚡ Quick Reference Table

| Topic | Key Syntax | Example |
|------|------------|---------|
| Variable | VAR="value" | NAME="DevOps" |
| Argument | $1, $2 | ./script.sh arg1 |
| If | if [ condition ]; then | if [ -f file ]; then |
| For loop | for i in list; do | for i in 1 2 3; do |
| Function | name() { ... } | greet() { echo "Hi"; } |
| Grep | grep pattern file | grep -i "error" log.txt |
| Awk | awk '{print $1}' file | awk -F: '{print $1}' /etc/passwd |
| Sed | sed 's/old/new/g' file | sed -i 's/foo/bar/g' file |

---

# 1️⃣ Basics

## Shebang
**Defines script interpreter — use `#!/bin/bash` at top so script bash me run ho.**
```bash
#!/bin/bash
```

## Running Scripts
**Script run karne ke 2 tareeke — executable banao ya bash se run karo.**
```bash
chmod +x script.sh
./script.sh
bash script.sh
```

## Comments
**Code explain karne ke liye comments use hote hain — `#` se likhte hain.**
```bash
# Single line
 echo "Hi" # Inline comment
```
**Code explain karne ke liye comments use hote hain — `<<` se likhte hain.**
```bash
<<Task
Multiline comment
Task
 echo "Hi" # Inline comment
```


## Variables
**Data store karne ke liye variables use hote hain — assign `VAR=value`, access `$VAR`.**
```bash
NAME="Nikhil"
echo $NAME
```

## User Input
**User se input lene ke liye `read` command use hoti hai.**
```bash
read -p "Enter name: " name
```

## Arguments (Functions)
**Function ke andar inputs `$1`, `$2` se access hote hain.**
**Script ko input dene ke liye CLI arguments use hote hain — `$1`, `$@`, `$#`.**
```bash
$0 script name
$1 first arg
$# total args
$@ all args
$? last exit code
```

---

# 2️⃣ Operators & Conditionals

## String Comparison
**Strings compare karne ke liye `[ ]` me operators use hote hain.**
```bash
[ "$a" = "$b" ] #Comparison
[ "$a" != "$b" ] # Not Equal to
[ -z "$a" ]   # empty
[ -n "$a" ]   # not empty
```

## Integer Comparison
**Numbers compare karne ke liye numeric operators use hote hain (-eq, -gt, etc.).**
```bash
-eq #equal to
-ne #not equal to
-lt #less then
-gt #greater then
-le # less then equal
-ge # Greater then equal
```

## File Tests
**File existence ya permissions check karne ke liye file test flags use hote hain.**
```bash
-f file  # file exists
-d dir   # directory
-e path  # exists
-r file  # readable
-w file  # writable
-x file  # executable
-s file  # not empty
```

## If Syntax
**Conditions check karke decision lene ke liye `if-elif-else` use hota hai.**
```bash
if [ condition ]; then
  echo ok
elif [ other Condition]; then
  echo other
else
  echo no
fi
```

## Logical Operators
**Multiple conditions combine karne ke liye AND (&&), OR (||), NOT (!) use hote hain.**
```bash
&& AND
|| OR
! NOT
```

## Case Statement
**Multiple values handle karne ke liye switch-like syntax `case` use hota hai.**
```bash
case $var in
  start) echo "Start" ;;
  stop) echo "Stop" ;;
  *) echo "Unknown" ;;
esac
```

---

# 3️⃣ Loops

## For Loop
**List ke har item par repeat kaam karne ke liye `for` loop use hota hai.**
```bash
for i in 1 2 3; do
  echo $i
done
```

## C-style Loop
**Counter-based looping ke liye C-style `for (( ))` use hota hai.**
```bash
for ((i=0;i<5;i++)); do
  echo $i
done
```

## While Loop
**Jab tak condition true ho tab tak loop chalane ke liye `while` use hota hai.**
```bash
while read line; do
  echo $line
done < file.txt
```

## Until Loop
**Jab tak condition false ho tab tak loop chalane ke liye `until` use hota hai.**
```bash
until [ $a -gt 5 ]; do
  ((a++))
done
```

## Loop Control
**Loop flow control karne ke liye `break` (stop) aur `continue` (skip) use hote hain.**
```bash
break
continue
```

## Loop Files
**Multiple files par kaam karne ke liye wildcard loops use hote hain.**
```bash
for file in *.log; do
  echo $file
done
```

---

# 4️⃣ Functions

## Define Function
**Reusable code block banane ke liye function define kiya jata hai.**
```bash
function greet() {
  echo "Hello"
}
```

## Call Function
**Function ka naam likhkar usse call/run kiya jata hai.**
```bash
greet
```

## Arguments
```bash
function add() {
  echo $(( $1 + $2 ))
}
```

## Return vs Echo
**`return` exit code deta hai, `echo` output print karta hai.**
```bash
return 1   # exit code
echo value # output
```

## Local Variables
**Function ke andar private variables banane ke liye `local` use hota hai.**
```bash
local var="inside"
```

---

# Text Processing Commands

## Grep
**Text search karne ke liye patterns match karta hai (logs filtering me useful).**
```bash
grep -i error file
grep -r error .
grep -c error file
grep -n error file
grep -v error file
grep -E "err|fail" file
```

## Awk
**Structured text process karne ke liye column-based processing tool hai.**
```bash
awk '{print $1}' file
awk -F: '{print $1}' file
awk 'BEGIN{print "Start"} {print $1} END{print "End"}'
```

## Sed
**Stream editor jo text replace/edit/delete karne me use hota hai.**
```bash
sed 's/old/new/g' file
sed -i 's/foo/bar/g' file
sed '2d' file
```

## Cut
**Delimiter based columns extract karne ke liye use hota hai.**
```bash
cut -d, -f1 file.csv
```

## Sort
**Lines ko alphabetical ya numeric order me arrange karta hai.**
```bash
sort file
sort -n nums.txt
sort -r file
sort -u file
```

## Uniq
**Duplicate lines remove ya count karne ke liye sorted data par use hota hai.**
```bash
uniq file
uniq -c file
```

## tr
**Characters replace ya delete karne ke liye stream transformer hai.**
```bash
tr 'a-z' 'A-Z'
tr -d '\n'
```

## wc
**File ka line, word, character count nikalne ke liye use hota hai.**
```bash
wc -l file #Line Count
wc -w file #Word Count
wc -c file #Charecter Count
```

## head / tail
**File ki starting ya ending lines dekhne aur logs follow karne ke liye use hota hai.**
```bash
head -n 10 file # first 10 Line
tail -n 10 file # Last 10 Line
tail -f log.txt # Last 10 Live
```

---

#  Useful One-Liners

## Delete files older than 7 days
**Old files cleanup karne ke liye find + mtime use hota hai.**
```bash
find . -type f -mtime +7 -delete
```

## Count lines in all logs
**Multiple log files ka total line count jaldi nikalne ke liye.**
```bash
wc -l *.log
```

## Replace text in multiple files
**Bulk text replacement ke liye sed with wildcard use hota hai.**
```bash
sed -i 's/old/new/g' *.txt
```

## Check service running
**Service active hai ya nahi check karne ke liye systemctl use hota hai.**
```bash
systemctl is-active nginx
```

## Disk usage alert
**High disk usage detect karne ke liye df + awk filter use hota hai.**
```bash
df -h | awk '$5+0 > 80 {print $0}'
```

## Real-time error monitoring
**Live logs me errors filter karne ke liye tail + grep pipeline use hoti hai.**
```bash
tail -f app.log | grep --line-buffered ERROR
```

---

#  Error Handling & Debugging

## Exit Codes
**Script success/failure status dene ke liye exit codes use hote hain.**
```bash
$?       # last exit code
exit 0   # success
exit 1   # failure
```

## Safety Flags
**Robust scripting ke liye bash safety options enable karte hain.**
```bash
set -e        # exit on error
set -u        # unset var error
set -o pipefail
set -x        # debug mode
```

## Trap Cleanup
**Script exit hone par cleanup actions run karne ke liye trap use hota hai.**
```bash
trap 'echo Cleanup' EXIT
```

---
s

