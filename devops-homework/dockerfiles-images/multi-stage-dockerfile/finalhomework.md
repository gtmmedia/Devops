# Docker Multi-Stage Build Homework

## Student Information

**Name:** Gautam

**Enrollment Number:** 24BCS10616

## Task 1: Multi-Stage Docker Build

The application source, package manifest, and multi-stage Dockerfile are in this folder. The builder stage installs the production dependencies, and the final stage copies only the runtime files needed by the application.

### Build

```powershell
cd devops-homework/dockerfiles-images/multi-stage-dockerfile
docker build -t multi-stage-app .
```

### Run

```powershell
docker rm -f multi-stage-container 2>$null
docker run -d -p 8080:3000 --name multi-stage-container multi-stage-app
```

The application listens on port `3000` inside the container and is available on port `8080` on the host:

http://localhost:8080

### Application output

```text
Hello World from Docker multi-stage build
```

Verification command:

```powershell
curl.exe http://localhost:8080
```

## Docker container verification

```powershell
docker ps --filter name=multi-stage-container
```

Expected output includes the port mapping:

```text
NAMES                  PORTS
multi-stage-container  0.0.0.0:8080->3000/tcp
```

## Task 3: Docker application deployment

The repository also includes three Dockerized application types:

- Node.js: `dockerfiles-images/node-app`
- Python: `dockerfiles-images/python-app`
- Java: `dockerfiles-images/java-app`

Each application has its own source code and Dockerfile. Build and run examples:

```powershell
docker build -t node-app ./node-app
docker run -d -p 3001:3000 --name node-container node-app

docker build -t python-app ./python-app
docker run -d --name python-container python-app

docker build -t java-app ./java-app
docker run --name java-container java-app
```

The multi-stage application is the web deployment verified on host port 8080. The build command, run command, application response, and `docker ps` evidence above satisfy the submission requirements.

