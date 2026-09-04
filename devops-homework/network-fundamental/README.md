# Network Fundamentals Homework

This submission records the basic Linux networking commands practiced during the networking session. The commands were run in a Linux environment, and the output below is from that run.

## Task 1: Practice commands and repository

The networking practice follows the commands and notes from the networking session in the `devops-heros` coursework.

## Task 2: Commands, output, and understanding

### 1. `ip -brief addr`

Shows the network interfaces and their addresses in a compact format. Here, `lo` is the loopback interface and `eth0` is the active Ethernet interface.

```text
lo               UNKNOWN        127.0.0.1/8 10.255.255.254/32 ::1/128
eth0             UP             172.24.205.217/20 fe80::215:5dff:fe5a:b8a1/64
```

### 2. `ip route`

Displays the routing table. The default route sends traffic through `172.24.192.1` using `eth0`.

```text
default via 172.24.192.1 dev eth0 proto kernel
172.24.192.0/20 dev eth0 proto kernel scope link src 172.24.205.217
```

### 3. `ping -c 2 127.0.0.1`

Tests connectivity to the local machine. The `-c 2` option sends two packets. Both packets were received, so local connectivity worked with 0% packet loss.

```text
PING 127.0.0.1 (127.0.0.1) 56(84) bytes of data.
64 bytes from 127.0.0.1: icmp_seq=1 ttl=64 time=22.0 ms
64 bytes from 127.0.0.1: icmp_seq=2 ttl=64 time=0.083 ms

--- 127.0.0.1 ping statistics ---
2 packets transmitted, 2 received, 0% packet loss
rtt min/avg/max/mdev = 0.083/11.066/22.049/10.983 ms
```

### 4. `getent hosts example.com`

Uses the system name-service configuration to resolve a hostname to IP addresses. The result returned IPv6 addresses for `example.com`.

```text
2606:4700:10::6814:179a example.com
2606:4700:10::ac42:93f3 example.com
```

### 5. `ss -tuln`

Lists listening TCP and UDP sockets without resolving service names. The output shows DNS listeners on port 53 and application listeners on ports 8080 and 3001.

```text
Netid   State    Recv-Q   Send-Q      Local Address:Port     Peer Address:Port
udp     UNCONN   0        0              127.0.0.54:53            0.0.0.0:*
udp     UNCONN   0        0           127.0.0.53%lo:53            0.0.0.0:*
tcp     LISTEN   0        1000       10.255.255.254:53            0.0.0.0:*
tcp     LISTEN   0        4096                    *:8080                *:*
tcp     LISTEN   0        4096                    *:3001                *:*
```

### 6. `curl -I https://example.com`

Sends an HTTP request and prints only the response headers. The `200` status confirms that the HTTPS request succeeded.

```text
HTTP/2 200
date: Fri, 04 Sep 2026 17:51:18 GMT
content-type: text/html
server: cloudflare
last-modified: Sun, 30 Aug 2026 04:11:49 GMT
allow: GET, HEAD
accept-ranges: bytes
age: 6203
cf-cache-status: HIT
cf-ray: a35ed76a5e0ab269-BOM
```

## Quick practice list

```bash
ip -brief addr
ip route
ping -c 2 127.0.0.1
getent hosts example.com
ss -tuln
curl -I https://example.com
```

These commands cover interface configuration, routing, local connectivity, DNS resolution, listening services, and HTTP connectivity.
