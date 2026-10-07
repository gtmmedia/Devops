# Kubernetes Homework - Session 20: Monitoring, Observability & GitOps

## Task 1: Monitoring Demo

Monitoring is the process of collecting, analyzing, and using information to track a program's progress toward reaching its objectives and to guide management decisions.

- **Metrics:** Quantitative data (numbers) that show how a system is performing over time (e.g., CPU 80%, Memory 1GB).
- **Logs:** Immutable, timestamped records of discrete events that happened over time (e.g., User A logged in at 10:00 AM).
- **Alerts:** Notifications triggered when metrics cross a predefined threshold (e.g., Send Slack message if CPU > 90%).

### Demo: Application Health & Resource Utilization
To demonstrate basic Kubernetes monitoring, run the following commands and insert your screenshots. Note: `metrics-server` must be installed.

1. **CPU and Memory Utilization:**
   ```bash
   kubectl top nodes
   kubectl top pods -A
   ```
   > *(Insert Screenshot of `kubectl top` outputs here)*

2. **Application Health (Logs & Events):**
   ```bash
   kubectl logs -n kube-system -l k8s-app=kube-dns
   kubectl get events -n default --sort-by='.metadata.creationTimestamp'
   ```
   > *(Insert Screenshot of Logs and Events here)*

---

## Task 2: Observability Documentation

Observability is a measure of how well internal states of a system can be inferred from knowledge of its external outputs.

### Why Observability is Required
As architectures shift from monoliths to microservices, traditional monitoring (which only tells you *if* a system is down) is no longer enough. Observability allows teams to ask arbitrary questions about their system and understand *why* it is broken, even for issues they have never seen before.

### The Three Pillars of Observability
1. **Metrics:** Aggregated data about the system. They are cheap to store and great for triggering alerts.
   - *Example Tool:* Prometheus.
2. **Logs:** Detailed information about discrete events. Crucial for deep-dive debugging once an alert fires.
   - *Example Tool:* Elasticsearch / Fluentd / Kibana (EFK Stack), Loki.
3. **Traces:** Representation of a single user's journey across the entire distributed architecture. Crucial for finding bottlenecks in microservices.
   - *Example Tool:* Jaeger, OpenTelemetry.

### Kubernetes Observability
Kubernetes is a highly dynamic environment. Pods are ephemeral, IPs change, and services autoscale. A modern Kubernetes observability stack typically relies on **Prometheus** for metrics collection (using ServiceMonitors) and **Grafana** for dashboarding and visualization.

---

## Task 3: GitOps Documentation & Demo

### What is GitOps?
GitOps is a set of practices to manage infrastructure and application configurations using Git. It takes the core principles of DevOps and applies them directly to infrastructure automation.

### Core Principles
1. **Git as the Source of Truth:** The desired state of the entire system (infrastructure and applications) is described declaratively and version-controlled in a Git repository.
2. **Declarative Configuration:** Everything is defined as code (YAML/JSON), not imperatively generated via scripts.
3. **Continuous Reconciliation:** A software agent (like ArgoCD or Flux) continuously monitors the Git repository. If the live state in the cluster diverges from the desired state in Git, the agent automatically pulls the changes and applies them to achieve reconciliation.

### GitOps Workflow
1. A developer pushes a change to a Kubernetes manifest in the Git repository.
2. The GitOps agent (e.g., ArgoCD running inside the cluster) detects the commit.
3. ArgoCD compares the Git state with the live Cluster state.
4. ArgoCD automatically runs `kubectl apply` to sync the cluster with the Git repository.

### GitOps Demo (ArgoCD)
If you are running the `08-mini-project` or the `07-argocd` setup, you will install ArgoCD and point it to a Git repository. 

1. **Install ArgoCD:**
   ```bash
   kubectl create namespace argocd
   kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
   ```
2. **Access the ArgoCD UI:**
   ```bash
   kubectl port-forward svc/argocd-server -n argocd 8080:443
   ```
3. **Sync an Application:**
   Create an Application resource in ArgoCD pointing to your GitHub repo and watch it deploy the resources to your cluster.

### Outputs & Screenshots
> *(Insert Screenshot of the ArgoCD UI showing a fully synced application here)*
