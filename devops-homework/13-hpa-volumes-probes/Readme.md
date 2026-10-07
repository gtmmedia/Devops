# Kubernetes Homework - Session 13: Storage, HPA & Probes

## Task 1: Kubernetes Volumes
Detailed documentation on `emptyDir`, `hostPath`, `PersistentVolume`, `PersistentVolumeClaim`, `StorageClass`, and Dynamic provisioning can be found in the `01-kubernetes-volumes/README.md` file.

---

## Task 2: HPA Hands-on

### Instructions:
1. **Deploy the application & Configure HPA:** Apply the deployment and HPA configurations. Ensure the Metrics Server is running in your cluster.
2. **Verify HPA:** Check the status of the HPA.
3. **Deploy a load generator:** Run a temporary pod to send a massive amount of traffic to your application.
4. **Observe Scaling:** Watch as the CPU utilization spikes and Kubernetes automatically scales up the number of pods.

### Commands to Run:
**1. Setup the environment:**
```bash
# Apply the application deployment, service, and HPA
kubectl apply -f hpa/

# Wait for the pod to be running
kubectl get pods
```

**2. Observe HPA and Pods (Run this in a separate terminal):**
```bash
# Watch the HPA scale in real-time
kubectl get hpa -w
```

**3. Run the Load Generator:**
```bash
# Run a busybox pod that continuously hits the service
kubectl run -i --tty load-generator --rm --image=busybox:1.28 --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"
```

**4. Check Metrics (After a few minutes of load):**
```bash
# View CPU usage of the pods
kubectl top pods

# Describe the HPA to see scaling events
kubectl describe hpa
```

### Outputs & Screenshots:

**1. HPA Status (`kubectl get hpa`):**
> *(Insert Screenshot here showing CPU targets increasing)*

**2. Pod Scaling (`kubectl get pods`):**
> *(Insert Screenshot here showing multiple new pods spinning up)*

**3. Metrics (`kubectl top pods` & `kubectl describe hpa`):**
> *(Insert Screenshot here showing the CPU utilization and the HPA scaling events)*

---

## Task 3: Mini Project

The mini-project combines Storage (PVC), HPA, Deployments, and Services into a cohesive architecture located in the `mini-project` folder.

### Implementation Steps:
You will apply the entire stack, which includes:
- A dedicated `Namespace`
- A `PersistentVolumeClaim` for storage
- A `Deployment` mounting the PVC
- A `Service` to expose the pods
- A `HorizontalPodAutoscaler` to manage scaling

### Commands to Run:
```bash
# 1. Apply the entire mini-project configuration
kubectl apply -f mini-project/

# 2. Verify all resources in the new namespace (e.g., 'mini-project-ns' or whatever is in namespace.yaml)
kubectl get all -n <namespace-name>

# 3. Verify the PVC is bound
kubectl get pvc -n <namespace-name>
```

### Outputs & Screenshots:
**1. Verifying the Deployment, Service, and HPA:**
> *(Insert Screenshot here showing `kubectl get all` for the mini-project namespace)*

**2. Verifying Storage:**
> *(Insert Screenshot here showing the PVC in `Bound` status)*