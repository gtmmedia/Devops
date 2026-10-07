# Task 4: CoreDNS in Kubernetes

## What is CoreDNS?
CoreDNS is a flexible, extensible DNS server written in Go that can serve as the Kubernetes cluster DNS. It is a CNCF graduated project and is the default DNS server for Kubernetes starting from version 1.13.

## Why Kubernetes uses CoreDNS
- **Performance & Reliability:** It is lightweight and fast.
- **Flexibility:** It uses a plugin-based architecture, making it easy to extend and customize.
- **Integration:** It deeply integrates with the Kubernetes API to dynamically serve DNS records based on the current state of Services and Pods in the cluster.

## How Service Discovery Works
1. When a new Service or Pod is created, the Kubernetes API server is updated.
2. CoreDNS continuously monitors the Kubernetes API for changes to Services and Endpoints.
3. Upon detecting a change, CoreDNS dynamically updates its internal routing table so that any subsequent DNS queries resolve to the new, correct IPs.

## How DNS Queries are Resolved
1. A Pod makes a DNS request (e.g., trying to resolve `my-service`).
2. The request is routed to the CoreDNS Pods (via the `kube-dns` Service).
3. CoreDNS checks its plugins. The `kubernetes` plugin inspects the query.
4. If the query matches a known Kubernetes Service, CoreDNS returns the corresponding ClusterIP.
5. If the query is external (e.g., `google.com`), CoreDNS forwards the request to the upstream DNS server specified in the node's `/etc/resolv.conf`.

## CoreDNS Configuration
CoreDNS is configured via a ConfigMap named `coredns` in the `kube-system` namespace. The main configuration file is the Corefile, which defines the server blocks and plugins.
Example ConfigMap structure:
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: coredns
  namespace: kube-system
data:
  Corefile: |
    .:53 {
        errors
        health
        kubernetes cluster.local in-addr.arpa ip6.arpa {
           pods insecure
           fallthrough in-addr.arpa ip6.arpa
        }
        prometheus :9153
        forward . /etc/resolv.conf
        cache 30
        loop
        reload
        loadbalance
    }
```

## How to Troubleshoot DNS Issues
1. **Check CoreDNS Pods:** Ensure they are running.
   ```bash
   kubectl get pods -n kube-system -l k8s-app=kube-dns
   ```
2. **Check CoreDNS Logs:** Look for errors or crash loops.
   ```bash
   kubectl logs -n kube-system -l k8s-app=kube-dns
   ```
3. **Test DNS from a Pod:** Run a busybox pod and use `nslookup`.
   ```bash
   kubectl run -it --rm --restart=Never dns-test --image=busybox:1.28 -- nslookup kubernetes.default
   ```
4. **Check the Endpoints:** Ensure your Service actually has backend endpoints (Pods).
   ```bash
   kubectl get endpoints <service-name>
   ```
5. **Inspect the CoreDNS ConfigMap:** Ensure the Corefile hasn't been misconfigured.
