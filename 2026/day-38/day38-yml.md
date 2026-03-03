Day 38:YAML Basics

Task1 & Task2

```bash

name: Nikhil Trivedi
role: DevOps Engineer
experience_years: 6
learning: true


name: Nikhil Trivedi
role: DevOps Engineer
experience_years: 6
learning: true
tools:
  - Linux
  - Networking
  - Shell Scripting
  - Git & Github
  - Docker
hobbies: [Playing Cricket, Coading]
```

Task3 & Task4

```bash
server:

  name: my_app
  ip: 192.168.0.1
  port: 5000

database:
  host: localhost
  name: MYSQL
  credentials:
    user: nikhil1234
    password: Test@123


server:

  name: my_app
  ip: 192.168.0.1
  port: 5000

  startup_script_preserves: |
    #!/bin/bash
    echo "Staring Application.."
    docker pull my_app:latest
    docker run -d -p 5000:5000 my_app:latest

  startup_script_fold: >
    #!/bin/bash
    echo "Starting Aplplication..."
    docker pull my_app:latest
    docker run -d -p 5000:5000 my_app:latest

    

database:
  host: localhost
  name: MYSQL
  credentials:
    user: nikhil1234
    password: Test@123

```

Write in your notes: When would you use | vs >?

```bash

*Literal Block (Preserves Newlines)
-Har line exactly waise hi rahegi
-Bash scripts, config files, certificates ke liye best
-Output me newline maintain hota hai

*Folded Block (Folds into One Line)
-Newlines ko space me convert kar deta hai
-Long descriptions ke liye use hota hai
-Script ke liye ideal nahi

```
