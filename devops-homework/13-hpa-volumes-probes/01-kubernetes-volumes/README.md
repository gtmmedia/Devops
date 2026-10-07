# Task 1: Kubernetes Volumes Documentation

Kubernetes Volumes provide a way to store and persist data beyond the lifecycle of a single container, and to share data between containers within the same Pod.

## 1. emptyDir
**What it is:** A temporary directory that is created when a Pod is assigned to a Node. It exists as long as the Pod is running on that node. If the Pod is deleted or evicted, the `emptyDir` is erased forever.
**Use Case:** Temporary scratch space, sharing files between two containers in the same Pod (e.g., one container fetches data, another serves it).
**Example:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: emptydir-demo
spec:
  containers:
  - name: my-container
    image: nginx
    volumeMounts:
    - mountPath: /cache
      name: cache-volume
  volumes:
  - name: cache-volume
    emptyDir: {}
```

## 2. hostPath
**What it is:** Mounts a file or directory from the host node's filesystem into your Pod.
**Use Case:** Running a Node-level daemon (like a log collector or monitoring agent) that needs to access `/var/log` or Docker internals on the actual host.
**Example:**
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: hostpath-demo
spec:
  containers:
  - name: my-container
    image: nginx
    volumeMounts:
    - mountPath: /host-logs
      name: host-logs-volume
  volumes:
  - name: host-logs-volume
    hostPath:
      path: /var/log
      type: Directory
```

## 3. PersistentVolume (PV)
**What it is:** A piece of storage in the cluster that has been provisioned by an administrator or dynamically provisioned using Storage Classes. It is a cluster-level resource (independent of any specific Pod's lifecycle).
**Use Case:** Provisioning a large NFS share, an AWS EBS volume, or a GCP Persistent Disk for long-term data storage (e.g., database files).

## 4. PersistentVolumeClaim (PVC)
**What it is:** A request for storage by a user. A PVC specifies the size, access modes (e.g., ReadWriteOnce), and StorageClass needed. Kubernetes then binds this claim to a matching PersistentVolume.
**Use Case:** A developer needs 10GB of storage for their database pod without needing to know the underlying cloud infrastructure details.
**Example:**
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
```

## 5. StorageClass
**What it is:** Provides a way for administrators to describe the "classes" of storage they offer. It defines the provisioner (the plugin that provisions PVs) and parameters for the storage.
**Use Case:** Defining a "fast" StorageClass using SSDs and a "slow" StorageClass using HDDs.

## 6. Dynamic Provisioning
**What it is:** Automatically creating PersistentVolumes on-demand when a user creates a PersistentVolumeClaim, eliminating the need for cluster administrators to pre-provision storage manually.
**How it works:** 
1. Admin creates a `StorageClass`.
2. Developer creates a `PVC` requesting that `StorageClass`.
3. Kubernetes uses the provisioner defined in the `StorageClass` to automatically create a volume in the cloud provider (e.g., AWS, Azure) and a matching `PV` object in the cluster.
