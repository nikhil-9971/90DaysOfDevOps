# 🐳 Docker Cheat Sheet

> Quick reference for daily Docker use — one line per command, job-ready.

---

## 📦 Container Commands

| Command | Description |
|---|---|
| `docker run nginx` | Run a container from image |
| `docker run -d nginx` | Run in detached (background) mode |
| `docker run -it ubuntu bash` | Run interactively with terminal |
| `docker run -p 8080:80 nginx` | Map host port 8080 → container port 80 |
| `docker run --name myapp nginx` | Give container a custom name |
| `docker run --rm nginx` | Auto-remove container when it stops |
| `docker run -e KEY=value nginx` | Pass environment variable |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers (including stopped) |
| `docker stop <id>` | Gracefully stop a container (SIGTERM) |
| `docker kill <id>` | Force stop a container (SIGKILL) |
| `docker rm <id>` | Remove a stopped container |
| `docker rm -f <id>` | Force remove a running container |
| `docker exec -it <id> bash` | Open shell inside running container |
| `docker logs <id>` | View container logs |
| `docker logs -f <id>` | Follow/stream live logs |
| `docker inspect <id>` | Full JSON details about container |
| `docker stats` | Live CPU/memory usage of containers |
| `docker cp file.txt <id>:/app/` | Copy file into container |

---

## 🖼️ Image Commands

| Command | Description |
|---|---|
| `docker build -t myapp .` | Build image from Dockerfile in current dir |
| `docker build -t myapp:v1.0 .` | Build with specific tag |
| `docker build --no-cache -t myapp .` | Build without using cache |
| `docker pull nginx` | Pull image from Docker Hub |
| `docker push user/myapp:latest` | Push image to Docker Hub |
| `docker tag myapp user/myapp:latest` | Tag image for pushing |
| `docker images` | List all local images |
| `docker images -a` | List all images including intermediates |
| `docker rmi <id>` | Remove an image |
| `docker rmi -f <id>` | Force remove image (even if in use) |
| `docker history myapp` | Show image layer history |
| `docker image inspect myapp` | Full details about an image |

---

## 💾 Volume Commands

| Command | Description |
|---|---|
| `docker volume create mydata` | Create a named volume |
| `docker volume ls` | List all volumes |
| `docker volume inspect mydata` | Show volume details and mount path |
| `docker volume rm mydata` | Remove a volume |
| `docker volume prune` | Remove all unused volumes |
| `docker run -v mydata:/app/data nginx` | Mount named volume into container |
| `docker run -v $(pwd):/app nginx` | Bind mount current dir into container |

---

## 🌐 Network Commands

| Command | Description |
|---|---|
| `docker network create mynet` | Create a custom bridge network |
| `docker network create --driver bridge mynet` | Explicitly set driver |
| `docker network ls` | List all networks |
| `docker network inspect mynet` | Show network details + connected containers |
| `docker network connect mynet <id>` | Connect running container to network |
| `docker network disconnect mynet <id>` | Disconnect container from network |
| `docker network rm mynet` | Remove a network |
| `docker run --network mynet nginx` | Run container on specific network |

---

## 🎼 Compose Commands

| Command | Description |
|---|---|
| `docker compose up` | Start all services (foreground) |
| `docker compose up -d` | Start all services (detached) |
| `docker compose up --build` | Rebuild images then start |
| `docker compose down` | Stop and remove containers + networks |
| `docker compose down -v` | Also remove named volumes (data deleted!) |
| `docker compose ps` | List running compose services |
| `docker compose logs` | View logs from all services |
| `docker compose logs -f app` | Follow logs from specific service |
| `docker compose exec app bash` | Shell into a running service |
| `docker compose build` | Build/rebuild images only |
| `docker compose pull` | Pull latest images for all services |
| `docker compose restart app` | Restart a specific service |
| `docker compose stop` | Stop services without removing them |
| `docker compose config` | Validate and view merged compose config |

---

## 🧹 Cleanup Commands

| Command | Description |
|---|---|
| `docker system df` | Show Docker disk usage |
| `docker system prune` | Remove all stopped containers, unused networks, dangling images |
| `docker system prune -a` | Also remove unused images (not just dangling) |
| `docker system prune --volumes` | Also remove unused volumes |
| `docker container prune` | Remove all stopped containers |
| `docker image prune` | Remove dangling images only |
| `docker image prune -a` | Remove all unused images |
| `docker volume prune` | Remove all unused volumes |
| `docker network prune` | Remove all unused networks |

---

## 📝 Dockerfile Instructions

| Instruction | Description |
|---|---|
| `FROM python:3.12-alpine` | Base image — always first instruction |
| `WORKDIR /app` | Set working directory (creates if not exists) |
| `COPY requirements.txt .` | Copy files from host to image |
| `ADD archive.tar.gz /app/` | Like COPY but also extracts archives & fetches URLs |
| `RUN pip install -r requirements.txt` | Execute command during build (creates new layer) |
| `ENV KEY=value` | Set environment variable (available at runtime) |
| `ARG NAME=default` | Build-time variable (not available at runtime) |
| `EXPOSE 5000` | Document which port the container listens on |
| `VOLUME ["/data"]` | Create a mount point for external volumes |
| `USER appuser` | Switch to non-root user |
| `CMD ["python", "app.py"]` | Default command — can be overridden at `docker run` |
| `ENTRYPOINT ["python"]` | Fixed entry — cannot be overridden (only args change) |
| `HEALTHCHECK CMD curl -f http://localhost/` | Define container health check |
| `LABEL version="1.0"` | Add metadata to image |
| `ONBUILD COPY . /app` | Trigger instruction for child images |

---

## ⚡ CMD vs ENTRYPOINT

```dockerfile
# CMD — default command, fully overridable
CMD ["python", "app.py"]
# docker run myapp              → runs python app.py
# docker run myapp bash         → runs bash (overrides CMD)

# ENTRYPOINT — fixed executable, only args change
ENTRYPOINT ["python"]
CMD ["app.py"]
# docker run myapp              → runs python app.py
# docker run myapp other.py     → runs python other.py

# Best practice: ENTRYPOINT for the binary, CMD for default args
```

---

## 🏗️ Multi-Stage Build Pattern

```dockerfile
# Stage 1: Build
FROM python:3.12-alpine AS builder
RUN pip install --target=/packages -r requirements.txt

# Stage 2: Runtime (only copies what's needed)
FROM python:3.12-alpine
COPY --from=builder /packages /packages
COPY . .
USER appuser
CMD ["python", "app.py"]
```

---

## 🔑 Key Flags Quick Reference

| Flag | Meaning |
|---|---|
| `-d` | Detached (background) |
| `-it` | Interactive + TTY (for shell access) |
| `-p host:container` | Port mapping |
| `-v name:path` | Volume mount |
| `-e KEY=val` | Environment variable |
| `--rm` | Auto-remove on exit |
| `--name` | Custom container name |
| `--network` | Attach to network |
| `--no-cache` | Build without cache |
| `-f` | Force (rm) or Follow (logs) |

---

*Last updated: Day 37 — Docker Revision*
