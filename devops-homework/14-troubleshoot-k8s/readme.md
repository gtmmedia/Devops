# Kubernetes Homework - Session 14: Troubleshooting

## Task 1: Kubernetes Commands Practice

Here are the most critical commands for troubleshooting Kubernetes. Run these in your cluster and insert screenshots of the outputs below.

1. **`kubectl get`**
   - *Purpose:* List resources and check their basic status.
   - *Example:* `kubectl get pods -A`
   > *(Insert Screenshot here)*

2. **`kubectl describe`**
   - *Purpose:* Get detailed information and events about a specific resource (critical for finding out *why* a pod failed).
   - *Example:* `kubectl describe pod <pod-name>`
   > *(Insert Screenshot here)*

3. **`kubectl logs`**
   - *Purpose:* View standard output (stdout) and standard error (stderr) of a container.
   - *Example:* `kubectl logs <pod-name> --previous`
   > *(Insert Screenshot here)*

4. **`kubectl exec`**
   - *Purpose:* Run commands directly inside a running container to test connectivity, check files, etc.
   - *Example:* `kubectl exec -it <pod-name> -- /bin/sh`
   > *(Insert Screenshot here)*

5. **`kubectl events`** (or `kubectl get events`)
   - *Purpose:* See cluster-wide events (scheduling, pulling images, restarts) sorted by time.
   - *Example:* `kubectl get events --sort-by='.metadata.creationTimestamp'`
   > *(Insert Screenshot here)*

6. **`kubectl explain`**
   - *Purpose:* Get documentation of resource fields right in your terminal.
   - *Example:* `kubectl explain pod.spec.containers.livenessProbe`
   > *(Insert Screenshot here)*

7. **`kubectl top`**
   - *Purpose:* Check real-time CPU and Memory usage of pods and nodes (requires metrics-server).
   - *Example:* `kubectl top pods`
   > *(Insert Screenshot here)*

8. **`kubectl get -o wide`**
   - *Purpose:* Get additional columns like the Node the pod is running on and the Pod's internal IP.
   - *Example:* `kubectl get pods -o wide`
   > *(Insert Screenshot here)*

---

## Task 2: Troubleshoot Common Issues

For each issue, apply the broken YAML from the copied reference folders (e.g., `06-crashloopbackoff`), investigate it, and document the fix.

### 1. CrashLoopBackOff
- **Problem:** Pod keeps crashing and restarting.
- **Investigation Steps:** `kubectl get pods`, followed by `kubectl logs <pod-name>`, and `kubectl describe pod <pod-name>`.
- **Root Cause:** Usually an application error, a missing configuration file, or an immediate exit command (e.g., `exit 1`).
- **Fix/Solution:** Update the application code, correct the config, or fix the command in the pod spec.
- **Before/After Output & Screenshots:**
  > *(Insert Screenshots here)*

### 2. ImagePullBackOff / ErrImagePull
- **Problem:** Pod fails to pull the container image.
- **Investigation Steps:** `kubectl get pods`, check the `Events` section in `kubectl describe pod <pod-name>`.
- **Root Cause:** A typo in the image name or tag, unauthorized access to a private registry, or the registry is unreachable.
- **Fix/Solution:** Correct the image name/tag in the deployment YAML and apply it.
- **Before/After Output & Screenshots:**
  > *(Insert Screenshots here)*

### 3. Pending
- **Problem:** Pod is stuck in Pending state and never schedules onto a Node.
- **Investigation Steps:** `kubectl describe pod <pod-name>` (look at the `Events` at the bottom).
- **Root Cause:** Insufficient cluster resources (CPU/Memory), untolerated taints, or requesting a PersistentVolumeClaim that doesn't exist.
- **Fix/Solution:** Free up resources, scale up nodes, or fix the PVC.
- **Before/After Output & Screenshots:**
  > *(Insert Screenshots here)*

### 4. ContainerCreating
- **Problem:** Pod is stuck in ContainerCreating state for a long time.
- **Investigation Steps:** `kubectl describe pod <pod-name>`.
- **Root Cause:** Often related to CNI (network plugin) issues, slow image downloads, or failing to mount a volume (like a ConfigMap or Secret that doesn't exist).
- **Fix/Solution:** Ensure the ConfigMap/Secret exists, or fix the volume mount paths.
- **Before/After Output & Screenshots:**
  > *(Insert Screenshots here)*

### 5. Service & DNS Connectivity Issues
- **Problem:** Unable to reach a service via its name.
- **Investigation Steps:** `kubectl exec` into a test pod. Run `nslookup <service-name>`. 
- **Root Cause:** The service doesn't exist, wrong namespace, or CoreDNS is down. Also, check if endpoints exist (`kubectl get endpoints`).
- **Fix/Solution:** Ensure the Service's `selector` exactly matches the Pod's `labels`.
- **Before/After Output & Screenshots:**
  > *(Insert Screenshots here)*

---

## Task 3: Mini Project

The `mini-project` folder contains a broken Kubernetes deployment architecture. Your goal is to find the bugs and fix them so the application runs correctly.

### Problem Statement:
The application was deployed, but it is not reachable, and the pods might not be starting correctly.

### Investigation Steps:
1. Apply the broken project: `kubectl apply -f mini-project/`
2. Check pods: `kubectl get pods` (Observe the states).
3. Use `kubectl describe pod` and `kubectl logs` to find the exact errors.
4. Check the service and endpoints: `kubectl get svc`, `kubectl get endpoints`.

### Expected Issues to Find (Root Causes):
*(Hint: You will likely find a typo in the image name, a missing ConfigMap/Secret, or a mismatch between the Service selector and the Deployment labels.)*

### Solution:
Edit the YAML files in the `mini-project` folder to fix the typos and mismatches, then re-apply: `kubectl apply -f mini-project/`.

### Before/After Output & Screenshots:
**Before (Failing State):**
> *(Insert Screenshot of failing pods/services here)*

**After (Fixed State):**
> *(Insert Screenshot of running pods and successful curl/access here)*