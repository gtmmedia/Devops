# Kubernetes Homework - Session 15: Helm

## Task 1: Helm Commands Practice

Here is a comprehensive list of the most critical Helm commands. Run each of them and paste your screenshots below to demonstrate your understanding.

1. **`helm create`**
   - *What it does:* Creates a new directory with a standard Helm chart structure.
   - *Example:* `helm create my-chart`
   > *(Insert Screenshot here)*

2. **`helm install`**
   - *What it does:* Installs a Helm chart into the Kubernetes cluster, creating a new "Release".
   - *Example:* `helm install my-release ./my-chart`
   > *(Insert Screenshot here)*

3. **`helm list`**
   - *What it does:* Lists all deployed Helm releases in the current namespace (or all namespaces with `-A`).
   - *Example:* `helm list`
   > *(Insert Screenshot here)*

4. **`helm status`**
   - *What it does:* Displays the current status of a deployed release, including notes and deployed resources.
   - *Example:* `helm status my-release`
   > *(Insert Screenshot here)*

5. **`helm get`**
   - *What it does:* Retrieves extended information about a release (e.g., `all`, `hooks`, `manifest`, `notes`, `values`).
   - *Example:* `helm get values my-release` or `helm get manifest my-release`
   > *(Insert Screenshot here)*

6. **`helm upgrade`**
   - *What it does:* Upgrades a release to a new version of a chart, or updates the configuration values of an existing release.
   - *Example:* `helm upgrade my-release ./my-chart --set replicaCount=3`
   > *(Insert Screenshot here)*

7. **`helm history`**
   - *What it does:* Shows the revision history of a specific release, including upgrades and rollbacks.
   - *Example:* `helm history my-release`
   > *(Insert Screenshot here)*

8. **`helm rollback`**
   - *What it does:* Reverts a release to a previous revision/version.
   - *Example:* `helm rollback my-release 1`
   > *(Insert Screenshot here)*

9. **`helm uninstall`**
   - *What it does:* Deletes a Helm release and all the Kubernetes resources associated with it.
   - *Example:* `helm uninstall my-release`
   > *(Insert Screenshot here)*

10. **`helm repo`**
    - *What it does:* Manages chart repositories (add, list, remove, update).
    - *Example:* `helm repo add bitnami https://charts.bitnami.com/bitnami` followed by `helm repo update`
    > *(Insert Screenshot here)*

11. **`helm search`**
    - *What it does:* Searches for charts in Helm Hub or your configured repositories.
    - *Example:* `helm search repo nginx`
    > *(Insert Screenshot here)*

---

## Task 2: Helm Rollback Workflow

In this task, we demonstrate the lifecycle of a deployment using Helm, including simulating a bad upgrade and rolling it back.

### 1. Install (Revision 1)
First, we deploy the initial version of our application.
```bash
helm install rollback-demo ./mini-project --set image.tag=v1.0.0
```

### 2. Upgrade (Revision 2)
We upgrade the application to a new version.
```bash
helm upgrade rollback-demo ./mini-project --set image.tag=v2.0.0
```

### 3. Verify (Revision 2)
Check the history to ensure Revision 2 is deployed.
```bash
helm history rollback-demo
kubectl get pods
```
> *(Insert Screenshot of Revision 2 verification here)*

### 4. Upgrade Again (Revision 3 - "The Bad Deployment")
We accidentally deploy a broken version (e.g., a non-existent image tag).
```bash
helm upgrade rollback-demo ./mini-project --set image.tag=v3.0.0-broken
```

### 5. Verify (Revision 3)
We notice the pods are crashing or failing to pull the image (`ImagePullBackOff`).
```bash
helm history rollback-demo
kubectl get pods
```
> *(Insert Screenshot of broken Revision 3 pods here)*

### 6. Rollback
We realize the mistake and immediately roll back to a known good state (Revision 2).
```bash
helm rollback rollback-demo 2
```

### 7. Verify (Rolled Back)
Check the history (a new Revision 4 is created identical to Revision 2) and verify pods are healthy again.
```bash
helm history rollback-demo
kubectl get pods
```
> *(Insert Screenshot of successful rollback and running pods here)*

---

## Task 3: Mini Project

The `mini-project` directory contains a complete custom Helm chart. 

### Instructions:
1. Review the `Chart.yaml` and `values.yaml` inside the `mini-project` folder to understand the configurable parameters.
2. Review the files inside the `templates/` folder (Deployment, Service, Ingress) to see how Helm injects the values using Go templating (e.g., `{{ .Values.replicaCount }}`).
3. Install the mini project:
   ```bash
   helm install my-webapp ./mini-project
   ```
4. Verify the resources were created successfully:
   ```bash
   kubectl get all -l app.kubernetes.io/instance=my-webapp
   ```
5. Upgrade the project (change the replica count or image):
   ```bash
   helm upgrade my-webapp ./mini-project --set replicaCount=3
   ```
6. Verify the scale out:
   ```bash
   kubectl get pods -l app.kubernetes.io/instance=my-webapp
   ```
7. When finished, uninstall it:
   ```bash
   helm uninstall my-webapp
   ```

### Outputs & Screenshots:
> *(Insert Screenshot of successful Mini Project installation and upgrade here)*
