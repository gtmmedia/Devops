# Docker Networking and Volume Homework

This folder contains the four requested Docker exercises. The commands below are written for PowerShell on Windows.

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

## Task 4: Overlay network

An overlay network connects Docker containers and services across multiple Docker hosts that belong to the same Docker Swarm. Swarm managers maintain the cluster state, while the overlay driver uses a VXLAN data path to route container traffic between hosts. Docker's embedded DNS allows services to find one another by service name across the overlay.

### Use cases

- Multi-host web, API, and database service deployments.
- Rolling updates and service replicas distributed across Docker hosts.
- Service-to-service communication without exposing every internal port publicly.
- Swarm service discovery and load balancing between replicas.

### Create and inspect an overlay network

Run on a Docker manager:

```powershell
docker swarm init
docker network create --driver overlay --attachable homework-overlay-net
docker network inspect homework-overlay-net --format "Name={{.Name}} Driver={{.Driver}} Scope={{.Scope}} Attachable={{.Attachable}}"
```

Verified output:

```text
Name=homework-overlay-net Driver=overlay Scope=swarm Attachable=true
```

The `--attachable` flag allows standalone containers to join the network. Without it, the overlay is intended for Swarm services.

### Use the overlay across Docker hosts

On the manager, obtain the worker join command:

```powershell
docker swarm join-token worker
```

Run the printed `docker swarm join ...` command on a second Docker host. Both hosts must be able to communicate over the Swarm control and data ports, commonly TCP `2377`, TCP/UDP `7946`, and UDP `4789`.

Then deploy a service on the overlay:

```powershell
docker service create --name overlay-web --network homework-overlay-net --publish published=8090,target=80 nginx:alpine
docker service ls
docker service ps overlay-web
```

The service can be scheduled on either Swarm host, while containers attached to `homework-overlay-net` can resolve and communicate with the service across hosts. Remove the demonstration service afterward:

```powershell
docker service rm overlay-web
```

Run cleanup when finished:

```powershell
.\cleanup.ps1
```