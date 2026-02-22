# Day 30 – Docker Images & Container Lifecycle


---

##  Task 1: Docker Images

### 🔹 Pull Images from Docker Hub
```bash
docker pull nginx
docker pull ubuntu
docker pull alpine
```

---

### 🔹 List All Images
```bash
docker images
```

**Observation:**
- Ubuntu image size: ~70–80MB
- Alpine image size: ~5–7MB
- Nginx: Moderate size

---

###  Ubuntu vs Alpine — Why Alpine is Smaller?
- Alpine is a minimal Linux distribution
- Uses musl libc instead of glibc
- Designed for containers
- Fewer packages → Smaller attack surface

**Conclusion:**  
Alpine is preferred for lightweight containers.

---

### Inspect an Image
```bash
docker inspect nginx
```

**Information Found:**
- Image ID
- Creation date
- Environment variables
- Layers
- Default command (CMD)
- Architecture

---

###  Remove an Image
```bash
docker rmi nikhil-nginx
```

(Removed unused image)

---

## Task 2: Image Layers

### View Image Layers
```bash
docker image history nginx
```

**Observation:**
- Each line represents a layer
- Some layers have sizes (actual changes)
- Some show 0B (metadata layers)

---

### 🔹 What are Docker Layers?
Docker images are built in layers. Each instruction in a Dockerfile creates a new layer.

**Why Docker uses layers:**
- Faster builds (layer caching)
- Efficient storage
- Layer reuse across images
- Faster pulls and pushes

---

##  Task 3: Container Lifecycle

Practiced full lifecycle using an Nginx container.

### 🔹 Create Container (Without Starting)
```bash
docker create --name nikhil-nginx -p 80:80 nginx
```

### 🔹 Start Container
```bash
docker start nikhil-nginx
```

### 🔹 Pause Container
```bash
docker pause nikhil-nginx
```

### 🔹 Unpause Container
```bash
docker unpause nikhil-nginx
```

### 🔹 Stop Container
```bash
docker stop nikhil-nginx
```

### 🔹 Restart Container
```bash
docker restart nikhil-nginx
```

### 🔹 Kill Container
```bash
docker kill nikhil-nginx
```

### 🔹 Remove Container
```bash
docker rm nikhil-nginx
```

---

## Task 4: Working with Running Containers

### 🔹 Run Nginx in Detached Mode
```bash
docker run -d --name live-nginx -p 80:80 nginx
```

### 🔹 View Logs
```bash
docker logs live-nginx
```

### 🔹 Real-Time Logs (Follow Mode)
```bash
docker logs -f live-nginx
```

### 🔹 Exec Into Container
```bash
docker exec -it live-nginx bash
```

### 🔹 Run Command Without Entering Container
```bash
docker exec live-nginx ls /
```

### 🔹 Inspect Container
```bash
docker inspect live-nginx
```

---

##  Task 5: Cleanup

### 🔹 Stop All Running Containers
```bash
docker stop $(docker ps -q)
```

### 🔹 Remove All Stopped Containers
```bash
docker container prune
```

### 🔹 Remove Unused Images
```bash
docker image prune
```

### 🔹 Check Docker Disk Usage
```bash
docker system df
```

---

