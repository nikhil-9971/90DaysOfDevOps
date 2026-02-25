# Day 32 – Docker Volumes & Networking 🚀



---

## 📌 Overview
Today’s focus was understanding how Docker handles **data persistence** and **container communication**.

I explored:
- What happens to data when a container is deleted
- Named volumes vs bind mounts
- Docker networking (default vs custom)
- Real-world app + database communication

---

# ✅ Task 1: The Problem (No Volumes)

## Steps
1. Ran a MySQL container
2. Created a database and table
3. Stopped and removed the container
4. Started a new container

## Result ❌
All data was gone.

## Why?
By default, container data is stored in the container’s writable layer.
When the container is deleted → data is deleted.

📸 **Screenshot:** Add container removal + empty DB proof

---

# ✅ Task 2: Named Volumes

## Step 1: Create volume
```bash
docker volume create mysql-data
```

## Step 2: Run MySQL with volume
```bash
docker run -d \
  --name mysql-db \
  -e MYSQL_ROOT_PASSWORD=Test@123 \
  -v mysql-data:/var/lib/mysql \
  mysql:8
```

## Step 3: Add data → remove container → recreate

```bash
docker rm -f mysql-db
```

Run again with same volume.

## Result ✅
Data was still there!

## Verify volumes
```bash
docker volume ls
docker volume inspect mysql-data
```

📸 **Screenshot:** Volume inspect output

---

# ✅ Task 3: Bind Mounts

## Step 1: Create folder on host
```bash
mkdir mysite
echo "<h1>Hello from Host</h1>" > mysite/index.html
```

## Step 2: Run Nginx with bind mount
```bash
docker run -d -p 80:80 \
  -v $(pwd)/code:/usr/share/nginx/html \
  nginx
```



## Step 3: Edit index.html on host → refresh browser
Changes reflected instantly ✅

## Named Volume vs Bind Mount
| Feature | Named Volume | Bind Mount |
|--------|-------------|------------|
| Managed by Docker | Yes | No |
| Host path control | No | Yes |
| Portability | High | Low |
| Best for | Databases | Dev environments |

📸 **Screenshot:** Browser output

---

# ✅ Task 4: Docker Networking Basics

## List networks
```bash
docker network ls
```

## Inspect default bridge
```bash
docker network inspect bridge
```

## Run 2 containers
```bash
docker run -dit --name container1 alpine sh
docker run -dit --name container2 alpine sh
```

### Ping by name ❌
```
ping container2  → fails
```

### Ping by IP ✅
```
docker inspect container2
ping <IP>
```

📸 **Screenshot:** Ping results

---

# ✅ Task 5: Custom Networks

## Create custom network
```bash
docker network create my-app-net
```

## Run containers on custom network
```bash
docker run -dit --name app1 --network my-app-net alpine sh
docker run -dit --name app2 --network my-app-net alpine sh
```

### Ping by name ✅
```
ping app2 → works
```

## Why it works?
Custom networks provide built-in Docker DNS.
Containers can resolve names automatically.

📸 **Screenshot:** Successful ping

---

# ✅ Task 6: Put It Together (Real DevOps Setup)

## Step 1: Create network
```bash
docker network create app-net
```

## Step 2: Run database with volume
```bash
docker run -d \
  --name mysql-db \
  --network app-net \
  -e MYSQL_ROOT_PASSWORD=Test@123 \
  -v mysql-appdata:/var/lib/mysql \
  mysql:8
```

## Step 3: Run app container
```bash
docker run -it --name myapp --network app-net ubuntu bash
```

## Step 4: Test connectivity
Inside app container:
```bash
apt update && apt install mysql-client -y
```

## Result ✅
App container successfully connected to database using container name.

📸 **Screenshot:** Successful DB connection

---

