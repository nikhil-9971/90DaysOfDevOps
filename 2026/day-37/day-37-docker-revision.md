# Day 37 – Docker Revision & Self-Assessment

> Honest self-check after Day 36's hands-on Dockerization project.

---

## ✅ Self-Assessment Checklist

| Topic | Status | Notes |
|---|---|---|
| Run a container from Docker Hub (interactive + detached) | ✅ Can Do | `docker run -it` and `docker run -d` — used both |
| List, stop, remove containers and images | ✅ Can Do | `docker ps`, `docker stop`, `docker rm`, `docker rmi` |
| Explain image layers and how caching works | ✅ Can Do | Each `RUN`/`COPY` = new layer; unchanged layers reuse cache |
| Write a Dockerfile from scratch | ✅ Can Do | Wrote multi-stage Dockerfile for Flask app from scratch |
| Explain CMD vs ENTRYPOINT | 🟡 Shaky | Know the difference conceptually, need more hands-on practice |
| Build and tag a custom image | ✅ Can Do | `docker build -t` and `docker tag` — pushed to Docker Hub |
| Create and use named volumes | ✅ Can Do | Used `mongo-data` volume in Compose for DB persistence |
| Use bind mounts | 🟡 Shaky | Understand the concept, haven't used in a real project yet |
| Create custom networks and connect containers | ✅ Can Do | Created `expense-net` bridge network in Compose |
| Write a docker-compose.yml for multi-container app | ✅ Can Do | Flask + MongoDB with healthchecks, networks, volumes |
| Use environment variables and .env files in Compose | ✅ Can Do | Debugged env var issues deeply — now very confident |
| Write a multi-stage Dockerfile | ✅ Can Do | 2-stage build: builder + runtime → 24.8MB final image |
| Push an image to Docker Hub | ✅ Can Do | `nikhil997164/expense-tracker` is live on Docker Hub |
| Use healthchecks and depends_on | ✅ Can Do | MongoDB healthcheck + `condition: service_healthy` |

**Score: 12/14 Can Do | 2 Shaky | 0 Haven't Done**

---

## 🔥 Quick-Fire Questions

### 1. What is the difference between an image and a container?

**Answer:**
An **image** is a read-only blueprint — a snapshot of the filesystem, dependencies, and instructions needed to run an application. Think of it like a class in OOP.

A **container** is a running instance of an image — it has its own isolated process, network, and writable filesystem layer on top of the image. Think of it like an object instantiated from a class.

```
Image (blueprint)  →  docker run  →  Container (running instance)
One image can spawn many containers simultaneously.
```

---

### 2. What happens to data inside a container when you remove it?

**Answer:**
It is **permanently lost**. Containers are ephemeral by design — the writable layer on top of the image is destroyed when the container is removed with `docker rm`.

To persist data, you must use:
- **Named volumes** (`-v mydata:/app/data`) — Docker-managed, survives container removal
- **Bind mounts** (`-v $(pwd):/app`) — maps a host directory into the container

This is exactly why I used a named volume `mongo-data` in Day 36 — so MongoDB data survives `docker compose down`.

---

### 3. How do two containers on the same custom network communicate?

**Answer:**
Docker provides **automatic DNS resolution** on custom networks. Containers can reach each other using their **service name** (in Compose) or **container name** as the hostname — no need for IP addresses.

Example from Day 36:
```yaml
# In docker-compose.yml
services:
  mongo:           # ← service name = hostname
    ...
  app:
    environment:
      MONGO_HOST: mongo   # app connects to mongo by name, not IP
```

Inside the `app` container, `ping mongo` resolves to the MongoDB container's IP automatically. This only works on **custom networks** — the default bridge network does NOT support DNS resolution by name.

---

### 4. What does `docker compose down -v` do differently from `docker compose down`?

**Answer:**

| Command | What it removes |
|---|---|
| `docker compose down` | Containers + Networks |
| `docker compose down -v` | Containers + Networks + **Named Volumes** |

The `-v` flag deletes all named volumes declared in the `volumes:` section of `docker-compose.yml`. This means **all database data is permanently wiped**.

Use `docker compose down` for normal restarts.
Use `docker compose down -v` only when you want a completely clean slate — like resetting a dev environment or fixing a corrupted database.

> ⚠️ I learned this the hard way on Day 36 — ran `down -v` during debugging and lost test data.

---

### 5. Why are multi-stage builds useful?

**Answer:**
Multi-stage builds allow you to **use one image for building and a completely different (smaller) image for running**.

Without multi-stage:
- `gcc`, `musl-dev`, `pip cache`, build tools all end up in the final image
- Final image: ~180MB+, larger attack surface

With multi-stage:
- Stage 1 (builder): installs all build dependencies, compiles packages
- Stage 2 (runtime): copies only the compiled output, starts fresh
- Final image: **24.8MB** — only what the app needs to run

Real example from Day 36:
```dockerfile
FROM python:3.12-alpine AS builder
RUN apk add gcc musl-dev          # build tools — Stage 1 only
RUN pip install --target=/packages -r requirements.txt

FROM python:3.12-alpine           # fresh image, no build tools
COPY --from=builder /packages /packages  # only the packages
```

**Result:** 24.8MB image instead of 180MB+. Faster pulls, smaller attack surface, cleaner production containers.

---

### 6. What is the difference between `COPY` and `ADD`?

**Answer:**

| | `COPY` | `ADD` |
|---|---|---|
| Copy local files | ✅ | ✅ |
| Extract `.tar.gz` archives | ❌ | ✅ Auto-extracts |
| Download from URLs | ❌ | ✅ |
| Predictable behavior | ✅ | ⚠️ Less predictable |
| Recommended for | Most cases | Archive extraction only |

**Best practice:** Always use `COPY` unless you specifically need archive extraction or URL fetching. `ADD` has implicit behaviors that can cause confusing bugs.

```dockerfile
COPY requirements.txt .        # ✅ Correct — simple file copy
ADD archive.tar.gz /app/data/  # ✅ OK — intentional extraction
ADD https://example.com/file . # ⚠️ Avoid — use curl/wget in RUN instead
```

---

### 7. What does `-p 8080:80` mean?

**Answer:**
It maps **host port 8080** to **container port 80**.

```
Your Browser → localhost:8080 → Docker → Container:80 → App
     (host)                              (container)
```

Format: `-p <HOST_PORT>:<CONTAINER_PORT>`

- **Left side** (8080) = port on YOUR machine you open in browser
- **Right side** (80) = port the app listens on INSIDE the container

Real example from Day 36:
```yaml
ports:
  - "5001:5000"   # localhost:5001 → container:5000
```
The app inside runs on 5000, but I access it at `localhost:5001` because port 5000 was taken by macOS AirPlay.

---

### 8. How do you check how much disk space Docker is using?

**Answer:**

```bash
docker system df
```

Output:
```
TYPE            TOTAL    ACTIVE   SIZE      RECLAIMABLE
Images          8        3        2.1GB     1.4GB (66%)
Containers      3        2        45MB      12MB (26%)
Local Volumes   4        2        890MB     200MB (22%)
Build Cache     12       0        340MB     340MB
```

To clean up and reclaim space:
```bash
docker system prune        # removes stopped containers, unused networks, dangling images
docker system prune -a     # also removes unused images
docker system prune -a --volumes  # nuclear option — removes everything unused
```

---

## 🔁 Weak Spot Revision

### Weak Area 1: CMD vs ENTRYPOINT (Hands-on)

```dockerfile
# Test 1: CMD only
FROM alpine
CMD ["echo", "Hello from CMD"]

# docker run mytest              → Hello from CMD
# docker run mytest echo "Hi"    → Hi  (CMD fully overridden)

# Test 2: ENTRYPOINT only
FROM alpine
ENTRYPOINT ["echo"]

# docker run mytest              → (blank — no args)
# docker run mytest "Hello"      → Hello

# Test 3: ENTRYPOINT + CMD together (Best Practice)
FROM alpine
ENTRYPOINT ["echo"]
CMD ["Hello, World!"]

# docker run mytest              → Hello, World!  (uses CMD as default args)
# docker run mytest "Custom"     → Custom  (overrides CMD args only)
```

**Key insight:** `ENTRYPOINT` sets the executable that always runs. `CMD` provides default arguments to that executable. Together they give you a flexible, predictable container interface.

---

### Weak Area 2: Bind Mounts (Hands-on)

```bash
# Bind mount — maps host directory into container
# Changes on host are instantly reflected inside container (and vice versa)

# Example: live development without rebuilding image
docker run -d \
  -p 5000:5000 \
  -v $(pwd)/app:/app/app \   # ← bind mount: host ./app → container /app/app
  --name dev-server \
  expense-tracker-app

# Now edit files on your host machine → changes appear instantly in container
# Perfect for development, not for production
```

**Named Volume vs Bind Mount:**

| | Named Volume | Bind Mount |
|---|---|---|
| Managed by | Docker | You (host path) |
| Use case | DB data persistence | Dev live reload |
| Portability | ✅ Any machine | ❌ Depends on host path |
| Performance | ✅ Optimized | Slower on macOS |

---

## 📊 Day 37 Summary

**What I revised today:**
- Went through all 14 checklist items honestly
- Answered all 8 quick-fire questions from memory
- Built a comprehensive cheat sheet I'll actually use on the job
- Did hands-on practice on CMD vs ENTRYPOINT and bind mounts

**Confidence level after Day 36-37:**
- Dockerfile writing: **High**
- Docker Compose: **High**
- Debugging container issues: **High** (Day 36 battle-tested this)
- Bind mounts in dev workflow: **Medium** (practiced today)
- Docker networking internals: **Medium** (need more depth)

**Next focus:** Docker in CI/CD pipelines — GitHub Actions building and pushing images automatically.

---

*Day 37 complete. Revision done. Cheat sheet ready. Moving forward.*
