# Task 3: Fully Qualified Domain Name (FQDN) in Kubernetes

## What is FQDN?
A Fully Qualified Domain Name (FQDN) is the complete domain name for a specific computer, or host, on the internet. It provides the exact location of the host within the domain name system hierarchy. For example: `www.google.com`.

## Kubernetes Service DNS
Kubernetes runs a DNS server (CoreDNS) within the cluster. When you create a Service, it automatically creates a DNS record for it. This allows Pods to find Services by their name instead of their IP address.

## Kubernetes DNS Naming Convention
The standard FQDN format for a Kubernetes Service is:
`<service-name>.<namespace>.svc.cluster.local`

- `<service-name>`: The name of the Service.
- `<namespace>`: The namespace the Service is located in.
- `svc`: Indicates that this is a Service.
- `cluster.local`: The default base domain for the cluster.

## Namespace-based DNS
Namespaces in Kubernetes provide a scope for names. 
- If a Pod and a Service are in the **same namespace**, the Pod can simply use the `<service-name>` to communicate with the Service.
- If the Pod and Service are in **different namespaces**, the Pod must use the FQDN or at least `<service-name>.<namespace>` to reach it.

## Pod-to-Service Communication
Pods use the cluster's DNS resolver. When an application in a Pod makes an HTTP request to a Service name (e.g., `http://my-database`), the DNS resolver translates that name into the Service's ClusterIP. The `kube-proxy` then routes the traffic to one of the backend Pods.

## Examples of Kubernetes FQDNs
1. A service named `frontend` in the `default` namespace:
   `frontend.default.svc.cluster.local`
2. A database service named `postgres-db` in the `production` namespace:
   `postgres-db.production.svc.cluster.local`
3. A headless service named `mongodb` returning exact Pod IPs in `data` namespace:
   `mongodb.data.svc.cluster.local`
