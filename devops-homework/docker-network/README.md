# Docker Networking and Volume Homework

This folder contains the three requested Docker exercises. The commands below are written for PowerShell on Windows.

## Task 1: Container networking

The setup creates three networks and three containers:

| Container         | Image        | Networks                                 |

| homework-frontend | nginx:alpine | `homework-frontend-net` |
| `homework-backend`| `alpine:3.20` | `homework-frontend-net`, `homework-backend-net` |
| `homework-db`     | `mysql:8.4` | `homework-backend-net`, `homework-db-net` |

The backend is the only container attached to two networks. Docker's embedded DNS lets containers resolve one another by container name only when they share a network.

Run the complete exercise:

```powershell
.\setup.ps1
```

The script verifies that the backend resolves the frontend and database, and that the database resolves the backend. It also performs the host-network and bind-mount tasks.

## Task 2: Host network

The script pulls `httpd:2.4-alpine`, starts `homework-apache` with `--network host`, and checks `http://localhost:80`. On Docker Desktop for Windows, host networking support depends on the Docker Desktop version and Linux engine configuration. If port 80 is already occupied, stop that service before running this test.

## Task 3: Bind mount

The script starts `homework-volume-nginx` with `./bind-mount:/usr/share/nginx/html:ro`, checks the initial `Hello students` page, updates `bind-mount/index.html`, and checks the updated content without restarting the container.

## Screenshots

### Apache host network

![Apache host-network page](screenshots/apache-host-network.png)

### Nginx bind mount

![Nginx bind-mount page](screenshots/nginx-bind-mount.png)

Run cleanup when finished:

```powershell
.\cleanup.ps1
```