# Kubernetes Homework - Session 12: Ingress, ConfigMaps & Secrets

## Task 1: ConfigMap Demo

### Instructions:
1. **Create ConfigMap:** Apply the YAML file to create the ConfigMap.
2. **Inject into Pod:** Deploy a Pod that mounts this ConfigMap as environment variables or a volume.
3. **Verify Values:** Exec into the pod and verify the config is present.

- **Commands:**
  ```bash
  # Apply ConfigMap and Pod YAMLs
  kubectl apply -f 01-configmap/
  
  # Wait for Pod to be running
  kubectl get pods
  
  # Exec into the container and check the environment variable
  kubectl exec -it <pod-name> -- sh -c "echo \$APP_COLOR"
  ```
- **Output & Screenshot:**
  > *(Insert Screenshot here showing the injected value, e.g., 'blue' or 'green')*

---

## Task 2: Secret Demo

### Instructions:
1. **Create Secret:** Apply the YAML file containing Base64 encoded sensitive values.
2. **Inject into Pod:** Deploy a Pod that references this Secret.
3. **Verify Value:** Exec into the container and check that the secret has been decoded and is available.

- **Commands:**
  ```bash
  # Apply Secret and Pod YAMLs
  kubectl apply -f 02-secret/
  
  # Exec into the container and check the secret
  kubectl exec -it <pod-name> -- sh -c "echo \$DB_PASSWORD"
  ```
- **Output & Screenshot:**
  > *(Insert Screenshot here showing the decoded secret)*

**Why Secrets should not be committed directly to Git:**
Secrets in Kubernetes are only encoded in Base64 (which is not encryption, just encoding). If you commit them to Git, anyone with repository access can easily run `echo "<base64-string>" | base64 -d` to decode your database passwords, API keys, and certificates, leading to serious security breaches. Instead, use tools like SealedSecrets, HashiCorp Vault, or External Secrets Operator to manage them.

---

## Task 3: Ingress Demo

### Instructions:
1. **Deploy application & Create Service:** Run the backend pods and expose them with a ClusterIP service.
2. **Configure Ingress:** Apply the Ingress rule to map a URL/path to the Service.
3. **Verify Routing:** Send a request to the Ingress controller to ensure traffic reaches the application.

- **Commands:**
  ```bash
  # Note: Ensure you have an ingress controller enabled (e.g. minikube addons enable ingress)
  kubectl apply -f 03-ingress/
  
  # Check Ingress host/IP
  kubectl get ingress
  
  # Test the route using curl (using the Ingress IP or configured domain)
  curl -H "Host: myapp.local" http://<INGRESS-IP>/
  ```
- **Output & Screenshot:**
  > *(Insert Screenshot here showing successful response from the application via Ingress)*

---

## Task 4: Ingress vs Ingress Controller

### What is Ingress?
An **Ingress** is a Kubernetes API object that defines rules for routing external HTTP(S) traffic to internal Services within the cluster. It acts like a configuration file containing routing rules (e.g., "route `/api` to `api-service` and `/web` to `web-service`").

### What is an Ingress Controller?
An **Ingress Controller** is the actual software/daemon running in the cluster that fulfills the rules defined in the Ingress object. It is usually a reverse proxy and load balancer (like NGINX, HAProxy, or Traefik) that watches the Kubernetes API for Ingress resources and updates its configuration dynamically to route traffic.

### Difference Between Them
- **Ingress:** The *rules* (the "What to do"). It is just a declarative YAML file.
- **Ingress Controller:** The *implementation* (the "How to do it"). It is the actual running pod (e.g., NGINX proxy) that routes the traffic based on those rules.

### Why Both Are Required
The Ingress object is meaningless on its own; without an Ingress Controller, creating an Ingress does absolutely nothing. The controller needs the Ingress rules to know where to route the traffic. Together, they decouple the routing rules (defined by developers) from the load balancing implementation (managed by cluster administrators).

### Examples
- **Ingress Rules:** `myapp-ingress.yaml` defining a rule for `foo.bar.com`.
- **Ingress Controllers:** NGINX Ingress Controller, Traefik, HAProxy Ingress, AWS ALB Ingress Controller.

---

## Task 5: Troubleshooting

### Problem Identification
- **Symptom:** The PostgreSQL database rejects the application connection with `FATAL: password authentication failed`.
- **Root Cause:** When encoding the password into Base64 for the Secret YAML, the developer used `echo "mypassword" | base64`. The standard `echo` command appends a newline (`\n`) to the string. The Base64 encoded string included this newline, so the password passed to the database was actually `mypassword\n` instead of `mypassword`.

### Fix the Issue
Always use the `-n` flag with `echo` to prevent the trailing newline when generating secrets.

- **Commands to run (Troubleshooting Steps):**
  ```bash
  # 1. See the wrong encoding
  echo "mypassword" | base64
  # Output: bXlwYXNzd29yZAo=
  
  # 2. Generate the correct encoding
  echo -n "mypassword" | base64
  # Output: bXlwYXNzd29yZA==
  ```
- **Output & Screenshot:**
  > *(Insert Screenshot here showing both echo commands and their different outputs)*