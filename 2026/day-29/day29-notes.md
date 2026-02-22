# Day 29 – Introduction to Docker

---

## Task 1: What is Docker?

### What is a Container?
A container is a lightweight, portable environment that packages an application with all its dependencies (libraries, runtime, configs).  
It ensures the app runs the same everywhere — laptop, server, or cloud.

**Why we need containers:**
- Eliminates "works on my machine" problem
- Lightweight compared to VMs
- Fast startup
- Easy deployment and scaling

---

###  Containers vs Virtual Machines

| Feature | Containers | Virtual Machines |
|--------|-----------|----------------|
| Size | Lightweight (MBs) | Heavy (GBs) |
| Boot time | Seconds | Minutes |
| OS | Share host OS kernel | Full OS per VM |
| Performance | Faster | Slower |
| Use case | Microservices, DevOps | Full isolation |

**Key Difference:**  
Containers share the host OS kernel, while VMs run their own full operating system.

---

###  Docker Architecture

Docker works in a client-server architecture:

**Components:**

1. **Docker Client**
   - CLI tool (`docker` command)
   - Sends commands to Docker daemon

2. **Docker Daemon (dockerd)**
   - Background service
   - Builds, runs, and manages containers

3. **Docker Images**
   - Read-only templates
   - Used to create containers

4. **Docker Containers**
   - Running instance of an image

5. **Docker Registry**
   - Stores images (Docker Hub, ECR, etc.)

---

### Docker Architecture (In My Words)
When I run a Docker command, the Docker CLI talks to the Docker daemon.  
The daemon pulls images from a registry (like Docker Hub) if needed, then creates and runs containers based on those images.

---

## Task 2: Install Docker

### Installation
```bash
sudo apt-get update
sudo apt-get install docker.io

---

### Verify Installation

```bash
docker --version


### for creating nginx container

docker run -d --name my-nginx -p 80:80 nginx


### for creating ubuntu container

docker run -itd ubuntu

### Enter inside container (Terminal)

docker exec -it <ubuntu container id> bash
