# Day 31 – Dockerfile: Build Your Own Images


---

## 🎯 Goal
Learn how to write Dockerfiles and build custom Docker images from scratch.

This is the skill that separates someone who **uses Docker** from someone who **ships with Docker**.

---

## 🧪 Task 1: Your First Dockerfile

### Folder Structure
my-first-image/
└── Dockerfile

### Dockerfile
```dockerfile
FROM ubuntu:22.04

RUN apt-get update && apt-get install -y curl

CMD ["echo", "Hello from my custom image!"]
```

### Build Image
```bash
docker build -t my-ubuntu:v1 .
```

### Run Container
```bash
docker run my-ubuntu:v1
```

✅ Output: Hello from my custom image!

---

## 🧪 Task 2: Dockerfile Instructions

### Dockerfile Example
```dockerfile
FROM ubuntu:22.04
RUN apt-get update && apt-get install -y curl
WORKDIR /app
COPY hello.txt .
EXPOSE 8080
CMD ["cat", "hello.txt"]
```

### Instruction Breakdown

| Instruction | Purpose |
|------------|---------|
| FROM | Base image |
| RUN | Executes commands during build |
| COPY | Copies files from host to image |
| WORKDIR | Sets working directory |
| EXPOSE | Documents port |
| CMD | Default runtime command |

---

## 🧪 Task 3: CMD vs ENTRYPOINT

### CMD Example
```dockerfile
FROM alpine
CMD ["echo", "hello"]
```

```bash
docker run image-name
# Output: hello

docker run image-name ls
# CMD overridden
```

### ENTRYPOINT Example
```dockerfile
FROM alpine
ENTRYPOINT ["echo"]
```

```bash
docker run image-name hello world
# Output: hello world
```

### 📝 Notes
- CMD = default command (can be overridden)
- ENTRYPOINT = fixed executable (arguments can be appended)

Use:
- CMD → flexible containers
- ENTRYPOINT → CLI-style containers

---

## 🧪 Task 4: Simple Web App Image

### index.html
```html
<h1>Hello from my Docker website 🚀</h1>
```

### Dockerfile
```dockerfile
FROM nginx:alpine
WORKDIR /app
RUN rm -rf /usr/share/nginx/html/*
COPY index.html /usr/share/nginx/html/
EXPOSE 80
```

### Build & Run
```bash
docker build -t my-website:v1 .
docker run -d -p 80:80 my-website:v1
```


---

## 🧪 Task 5: .dockerignore

### .dockerignore
```
node_modules
.git
*.md
.env
```

✅ Prevents unnecessary files from entering build context.

---

## 🧪 Task 6: Build Optimization

### Observation
- First build = slow
- Rebuild after small change = faster (layer caching)

### Why Layer Order Matters
Docker caches layers from top to bottom.

👉 Best Practice:
- Put stable steps first (dependencies)
- Put frequently changing code last

Example:
```dockerfile
# Good
COPY package.json .
RUN npm install
COPY . .
```

---

