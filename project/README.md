Here is a comprehensive `README.md` tailored for your **`project`** directory containing your Node.js application, Dockerfile, and Taskfile:

```markdown
# DevOps Web Application Service

This directory contains the source code, containerization configuration, and task orchestration scripts for the Node.js web application.

---

## 📁 Directory Structure

```text
project/
├── app.js           # Node.js application entry point
├── package.json     # Node.js dependencies and script definitions
├── Dockerfile       # Production multi-stage, rootless Docker container build
└── Taskfile.yml     # Task runner configuration for local development & deployment

```

---

## 🛠 Local Setup & Prerequisites

Before running or deploying the application locally, ensure you have the following installed:

* **Node.js**: v20+
* **Docker**: Engine 20.10+
* **Task CLI**: Installed via brew or install script (`task --version`)
* **Doppler CLI**: Installed for secret management (`doppler --version`)

---

## 🚀 Development Tasks (`Taskfile.yml`)

Instead of running long `docker` or `npm` commands manually, use `task` commands to manage the application lifecycle:

### 1. Build Docker Image

Builds the lightweight `node:20-alpine` Docker image locally:

```bash
task build

```

### 2. Clean Existing Containers

Stops and removes running application containers and cleanup unused image layers:

```bash
task clean

```

### 3. Deploy Container with Doppler Secrets

Deploy the application with your `WEBTEXT` environment secret injected securely via Doppler:

First, set your `DOPPLER_TOKEN`:

```bash
export DOPPLER_TOKEN="your_doppler_service_token"

```

Then run the deployment task:

```bash
task deploywithdoppler

```

---

## 🐳 Docker Container Features

The [`Dockerfile`](https://github.com/sharathp238/web-text/raw/refs/heads/webtext/project/Dockerfile?utm_source=gemini) follows best practices for security and production environments:

* **Base Image**: Lightweight `node:20-alpine` footprint.
* **Rootless Security**: Runs under unprivileged user (`USER 1000:1000`) to enforce security compliance.
* **Native Healthcheck**: Built-in HTTP health check monitoring port `80` every 5 seconds.
* **Dependency Optimization**: Installs production dependencies only (`npm install --omit=dev`).

---

## 🌐 Application Health Check

Once the container is running locally or on the target host:

* **URL**: `http://localhost:80`
* **Health Check Command**:
```bash
curl -i http://localhost:80/

```



```

---

### How to add this file to GitHub:
1. Navigate to the **[`project`](https://github.com/sharathp238/web-text/tree/webtext/project/project)** folder in your repository.
2. Click **Add file > Create new file**.
3. Set the name to **`README.md`**.
4. Paste the Markdown content above and click **Commit changes...**.

```
