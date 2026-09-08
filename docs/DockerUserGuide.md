# 📘 User Guide & Docker Deployment Documentation

This guide covers containerization, deployment, and usage of the Node.js / Express application with local SQLite persistence and non-root security.

---

## 📋 Table of Contents

1. [Architecture & Specifications](#-architecture--specifications)
2. [Prerequisites](#-prerequisites)
3. [Project Structure](#-project-structure)
4. [Multi-Stage Dockerfile](#-multi-stage-dockerfile)
5. [Quick Start Guide](#-quick-start-guide)
6. [Useful Daily Commands](#-useful-daily-commands)
7. [Data Persistence](#-data-persistence)
8. [CI/CD Integration](#-cicd-integration)
9. [Troubleshooting (FAQ)](#-troubleshooting-faq)

---

## ⚙️ Architecture & Specifications

- **Runtime:** Node.js 22 (Debian Bookworm Slim / standard Glibc support).
- **Database:** SQLite3 stored locally at `/app/data/todo.db`.
- **Security:** Runs under an unprivileged user (`USER node`, UID 1000).
- **Build strategy:** Multi-stage build, isolating C++ dependencies / `build-essential` to the builder stage.

---

## 📦 Prerequisites

- **Docker Engine** (version 20.10 or higher)
- **Git**
- A Bash / Zsh / PowerShell terminal

---

## 📁 Project Structure

Make sure your project follows the structure below:

```text
.
├── Dockerfile
├── .dockerignore
├── package.json
├── package-lock.json
├── data/
│   └── todo.db          # Local database
└── src/
    ├── index.js
    └── persistence/
        └── sqlite.js
```

### Recommended `.dockerignore`

```text
node_modules
npm-debug.log
.git
.gitignore
.env
```

---

## 🛠 Multi-Stage Dockerfile

Here is the validated `Dockerfile`:

```dockerfile
# =========================================================
# Stage 1: Build (compile native modules)
# =========================================================
FROM node:22-bookworm-slim AS builder

WORKDIR /app

# System tools required to compile native modules (sqlite3)
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    make \
    g++ \
  && rm -rf /var/lib/apt/lists/*

COPY package*.json ./

# Clean installation of production dependencies
RUN if [ -f package-lock.json ]; then \
      npm ci --omit=dev; \
    else \
      npm install --omit=dev; \
    fi && \
    npm cache clean --force

# =========================================================
# Stage 2: Runtime (minimal image & non-root execution)
# =========================================================
FROM node:22-bookworm-slim AS runner

ENV NODE_ENV=production

WORKDIR /app

# Copy pre-built modules
COPY --from=builder --chown=node:node /app/node_modules ./node_modules

# Copy source and configuration files
COPY --chown=node:node package.json ./
COPY --chown=node:node src/ ./src/

# Prepare the data directory with permissions for the 'node' user
RUN mkdir -p /app/data && chown -R node:node /app

# Switch to the non-root user
USER node

EXPOSE 3000

CMD ["node", "src/index.js"]
```

---

## 🚀 Quick Start Guide

### 1. Build the Docker Image

Run this command from the repository root:

```bash
docker build -t todo_list .
```

### 2. Start the Container

Start the container in the background and map port `3000`:

```bash
docker run -d --name app-todo -p 3000:3000 todo_list
```

### 3. Verify the Application

Check the container logs:

```bash
docker logs app-todo
```

The application should indicate that it is listening on port `3000`.

You can access the application from your browser:

👉 **http://localhost:3000**

---

## 💻 Useful Daily Commands

| Action | Command |
| :--- | :--- |
| **Check status** | `docker ps` |
| **Follow logs in real time** | `docker logs -f app-todo` |
| **Stop the container** | `docker stop app-todo` |
| **Restart the container** | `docker start app-todo` |
| **Remove the container** | `docker rm -f app-todo` |
| **Check the active user** | `docker exec app-todo id` *(should display `uid=1000(node)`)* |
| **Open a shell inside the container** | `docker exec -it app-todo /bin/bash` |

---

## 💾 Data Persistence

By default, if the container is removed, the SQLite database located at `/app/data/todo.db` is reset.

To preserve your data between container updates or restarts, use a **named Docker volume**:

```bash
# Start with persistent storage
docker run -d \
  --name app-todo \
  -p 3000:3000 \
  -v todo-data:/app/data \
  todo_list
```

---

## 🔄 CI/CD Integration

Example pipeline configuration for GitHub Actions (`.github/workflows/ci.yml`):

```yaml
name: CI

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  docker-build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout source code
        uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Validate Docker build
        run: |
          docker build -t todo_list:test .

      - name: Test container startup
        run: |
          docker run -d --name test-container -p 3000:3000 todo_list:test
          sleep 5
          docker logs test-container
          docker exec test-container id | grep "uid=1000(node)"
```

---

## ❓ Troubleshooting (FAQ)

### 1. Error: `Bind for 0.0.0.0:3000 failed: port is already allocated`

Port `3000` on the host machine is already being used by another process or container.

- **Option A:** Free the port:

  ```bash
  sudo fuser -k 3000/tcp
  ```

- **Option B:** Map the container to another local port, such as `8080`:

  ```bash
  docker run -d --name app-todo -p 8080:3000 todo_list
  ```

### 2. Error: `EACCES: permission denied, mkdir '/app/data'`

The non-root user does not have permission to write to the directory.

- Make sure you rebuilt the image using:

  ```bash
  docker build --no-cache -t todo_list .
  ```

- Also verify that the following line is present in the `Dockerfile`:

  ```dockerfile
  RUN mkdir -p /app/data && chown -R node:node /app
  ```

### 3. Error: `failed to solve: open Dockerfile: no such file or directory`

Docker cannot find the Dockerfile in your current working directory.

- Check your current directory:

  ```bash
  pwd
  ```

- Make sure the file is named exactly `Dockerfile` (**capital D, no `.txt` extension**).