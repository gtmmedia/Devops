# Hello World Applications

Six independent Dockerized web applications are included: Node.js, Python, Java, Apache, React, and Nginx.

Build and run from this folder:

```bash
docker build -t hello-node ./node
docker run --rm -d --name hello-node -p 3001:3000 hello-node
docker build -t hello-python ./python
docker run --rm -d --name hello-python -p 3002:8000 hello-python
docker build -t hello-java ./java
docker run --rm -d --name hello-java -p 3003:8080 hello-java
docker build -t hello-apache ./apache
docker run --rm -d --name hello-apache -p 3004:80 hello-apache
docker build -t hello-react ./react
docker run --rm -d --name hello-react -p 3005:80 hello-react
docker build -t hello-nginx ./nginx
docker run --rm -d --name hello-nginx -p 3006:80 hello-nginx
```

Verify with `curl http://localhost:3001` through `curl http://localhost:3006`, or open those URLs in a browser. Clean up with:

```bash
docker rm -f hello-node hello-python hello-java hello-apache hello-react hello-nginx
```