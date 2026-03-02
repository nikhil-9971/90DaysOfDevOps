# Day 36 – Docker Project: Dockerize a Full Application

## App Choice: Expense Tracker (Flask + MongoDB)

### Why This App?

I chose to build an **Expense Tracker** instead of a generic todo app because it closely mirrors real-world applications — it has authentication, a NoSQL database, persistent data, environment-based configuration, and a professional UI. These are exactly the kinds of challenges you face when Dockerizing production apps on the job.

The stack:
- **Python Flask** — lightweight, production-ready with Gunicorn
- **MongoDB** — NoSQL, great for flexible financial documents
- **Docker + Compose** — full containerization with networking, volumes, and healthchecks

---

## Project Structure

```
expense-tracker/
├── app/
│   ├── __init__.py          # App factory, MongoDB connection
│   ├── models.py            # Document schema + categories
│   ├── routes.py            # All CRUD routes
│   ├── templates/
│   │   ├── base.html        # Shared layout + nav
│   │   ├── index.html       # Transactions list
│   │   ├── add.html         # Add expense form
│   │   └── analytics.html   # Spending charts
│   └── static/css/
│       └── style.css        # Dark luxury fintech UI
├── Dockerfile
├── docker-compose.yml
├── .dockerignore
├── .env.example
├── run.py
└── requirements.txt
```

---

## The Dockerfile (with comments)

```dockerfile
# ── Stage 1: Builder ──────────────────────────────────────────────────────────
# Use Alpine variant — minimal Linux, no bloat
FROM python:3.12-alpine AS builder

WORKDIR /app

# Install gcc + musl-dev: needed to compile Python C extensions like pymongo
# Without these, pip install fails on Alpine for packages with native code
RUN apk add --no-cache gcc musl-dev

# Copy only requirements first — Docker layer caching optimization
# If requirements.txt hasn't changed, this layer is reused on rebuild
COPY requirements.txt .

# Install all packages into /app/packages directory
# --target keeps packages isolated and easy to copy to next stage
# --no-cache-dir reduces image size by not storing pip's download cache
RUN pip install --no-cache-dir -r requirements.txt --target=/app/packages

# ── Stage 2: Runtime ──────────────────────────────────────────────────────────
# Fresh Alpine image — build tools from Stage 1 are completely discarded
# This is why multi-stage builds are powerful: final image has zero build deps
FROM python:3.12-alpine

WORKDIR /app

# Copy ONLY the installed packages from builder stage
# gcc, musl-dev, pip cache — all left behind in Stage 1
COPY --from=builder /app/packages /app/packages

# Copy application source code
COPY . .

# Security best practice: never run containers as root
# Create a dedicated non-privileged system user and group
# -S = system account (no password, no home dir)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup \
    && chown -R appuser:appgroup /app

# Tell Python where to find our installed packages
ENV PYTHONPATH=/app/packages

# Switch to non-root user for all subsequent commands
USER appuser

# Document that the app listens on port 5000 (informational)
EXPOSE 5000

# Run with Gunicorn — production WSGI server
# --bind 0.0.0.0:5000 → listen on all interfaces inside container
# --workers 2 → 2 worker processes for handling concurrent requests
# run:app → import 'app' object from 'run.py'
CMD ["python", "-m", "gunicorn", "--bind", "0.0.0.0:5000", "--workers", "2", "run:app"]
```

### Why Multi-Stage?

| | Single Stage | Multi-Stage |
|---|---|---|
| gcc, musl-dev in final image | ✅ Yes | ❌ No |
| pip cache in final image | ✅ Yes | ❌ No |
| Final image size | ~180MB+ | **24.8MB** |
| Attack surface | Large | Minimal |

---

## docker-compose.yml

```yaml
version: "3.9"

networks:
  expense-net:
    driver: bridge        # Isolated network — containers talk by service name

volumes:
  mongo-data:             # Named volume — data persists across container restarts

services:
  mongo:
    image: mongo:6.0
    container_name: expense-mongo
    restart: unless-stopped
    environment:
      MONGO_INITDB_ROOT_USERNAME: ${MONGO_USER}
      MONGO_INITDB_ROOT_PASSWORD: ${MONGO_PASS}
    volumes:
      - mongo-data:/data/db
    networks:
      - expense-net
    healthcheck:
      test: ["CMD", "mongosh", "-u", "${MONGO_USER}", "-p", "${MONGO_PASS}",
             "--authenticationDatabase", "admin", "--eval", "db.adminCommand('ping')"]
      interval: 15s
      timeout: 10s
      retries: 5
      start_period: 40s

  app:
    build: .
    container_name: expense-app
    restart: unless-stopped
    ports:
      - "${APP_PORT}:5000"
    environment:
      MONGO_USER: ${MONGO_USER}
      MONGO_PASS: ${MONGO_PASS}
      MONGO_HOST: ${MONGO_HOST}
      MONGO_DB: ${MONGO_DB}
      SECRET_KEY: ${SECRET_KEY}
    networks:
      - expense-net
    depends_on:
      mongo:
        condition: service_healthy   # App waits until MongoDB passes healthcheck
```

---

## Challenges Faced & How I Solved Them

### Challenge 1: MongoDB Container Dying at Startup
**Error:** `dependency mongo failed to start`

**Root Cause:** The `mongo:7-jammy` image was too heavy and the healthcheck was timing out before MongoDB fully initialized.

**Fix:** Switched to `mongo:6.0` (lighter, more stable) and increased `start_period` to 40s to give MongoDB enough time to boot before Docker started counting healthcheck failures.

---

### Challenge 2: Multi-Stage Build — `/install` Not Found
**Error:**
```
failed to calculate checksum of ref: "/install": not found
```

**Root Cause:** Used `pip install --prefix=/install` which doesn't reliably create the `/install` directory on Alpine with `--no-cache-dir`.

**Fix:** Switched to `--target=/app/packages` which explicitly creates the target directory and is fully reliable across all base images.

---

### Challenge 3: Permission Denied on Gunicorn
**Error:**
```
/usr/local/bin/python3.12: can't open file '/root/.local/bin/gunicorn': Permission denied
```

**Root Cause:** Used `pip install --user` which installs to `/root/.local` — a directory the non-root `appuser` cannot read.

**Fix:** Used `--target=/app/packages` instead and set `ENV PYTHONPATH=/app/packages` so Python finds the packages regardless of which user is running.

---

### Challenge 4: MongoDB Authentication URI Error
**Error:**
```
pymongo.errors.InvalidURI: Username and password must be escaped according to RFC 3986
```

**Root Cause:** The MongoDB URI was being constructed with raw strings. Special characters in passwords break URI parsing.

**Fix:** Used `urllib.parse.quote_plus()` to properly encode username and password before embedding them in the URI.

---

### Challenge 5: Env Variables Not Reaching the Container
**Error:**
```
>>> Connecting: user=None host=mongo db=expensedb
```

**Root Cause:** `env_file` in docker-compose wasn't loading correctly due to `.env` file format issues.

**Fix:** Explicitly declared each environment variable under the `environment:` key in `docker-compose.yml`, pulling values from `.env` using `${VAR}` syntax — which is reliably interpolated by Docker Compose at runtime.

---

### Challenge 6: Port 5000 Already in Use
**Error:**
```
bind: address already in use
```

**Root Cause:** macOS AirPlay Receiver uses port 5000 by default.

**Fix:** Changed host port to `5001` in `.env`:
```env
APP_PORT=5001
```

---

## Final Image Size

```bash
$ docker images expense-tracker-app

REPOSITORY             TAG       SIZE
expense-tracker-app    latest    24.8MB
```

**24.8MB** — achieved through:
- `python:3.12-alpine` base (vs ~900MB for full Python)
- Multi-stage build (build tools stripped from final image)
- `--no-cache-dir` on pip install
- Only production dependencies (`gunicorn`, `pymongo`, `flask`)

---

## Docker Hub

🐳 **Public Image:** [https://hub.docker.com/r/nikhil997164/expense-tracker](https://hub.docker.com/r/nikhil997164/expense-tracker)

### Pull & Run (no clone needed)

```bash
# Pull image
docker pull nikhil997164/expense-tracker:latest

# Create .env file
cat > .env << EOF
MONGO_USER=expenseuser
MONGO_PASS=password123
MONGO_HOST=mongo
MONGO_DB=expensedb
SECRET_KEY=mysecretkey123
APP_PORT=5001
EOF

# Run with compose
docker compose up -d

# Open browser
open http://localhost:5001
```

---

## Key Learnings

| Concept | What I Learned |
|---|---|
| Multi-stage builds | Separate build and runtime — keeps final image tiny |
| Non-root user | `appuser` runs Gunicorn — security best practice |
| Alpine base | 24.8MB final image vs 900MB+ without it |
| `--target` vs `--user` | `--target` is reliable across all base images |
| Healthchecks | `depends_on: condition: service_healthy` is critical |
| Named volumes | Data survives `docker compose down` and restarts |
| Custom networks | Service DNS — app reaches mongo by hostname, not IP |
| Env var scoping | Always use `environment:` block, not just `env_file` |
| RFC 3986 | Passwords in URIs must be URL-encoded |
| Port conflicts | macOS port 5000 = AirPlay. Always check before binding |

---

> *"Every error in Docker is a lesson. The healthcheck timeout, the permission denied, the None username — none of these appear in tutorials. They appear in production. Day 36 prepared me for that."*

