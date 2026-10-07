# Kubernetes Homework - Session 17: Complete CI/CD & DevSecOps

## Task: DevSecOps Demo Project

In this session, we evolve our standard CI/CD pipeline by injecting continuous security testing directly into our workflow. This practice, known as DevSecOps, ensures that vulnerabilities are caught early in the development lifecycle (shifting left).

### The DevSecOps Flow
The expected flow of this pipeline is:
`Code -> Build -> Unit Test -> SAST -> SCA -> Secret Scan -> Docker Build -> Container Image Scan -> Security Gate -> Push Image -> Deploy to Kubernetes`

### Security Tools Used
- **SAST (Static Application Security Testing):** Analyzes the raw source code for security vulnerabilities without executing the code (e.g., SonarQube, GitHub CodeQL).
- **SCA (Software Composition Analysis):** Scans the `package.json` or `requirements.txt` to find known vulnerabilities in 3rd-party open-source dependencies (e.g., Snyk, OWASP Dependency-Check).
- **Secret Scanning:** Scans the codebase to prevent hardcoded passwords, API keys, or tokens from being committed (e.g., TruffleHog, GitLeaks).
- **Container Image Scanning:** Scans the built Docker image for OS-level or package-level vulnerabilities before pushing it to the registry (e.g., Trivy, Clair).
- **Security Gates:** A hard stop in the pipeline. If critical vulnerabilities are found, the build fails, and the image is *not* pushed or deployed.

---

## 1. The Application & Kubernetes Manifests
The application source code, Dockerfile, and Kubernetes deployment YAML files are located in the `demo` folder. 
Ensure you push this code to your GitHub repository.

---

## 2. GitHub Actions DevSecOps Workflow
Create the file `.github/workflows/devsecops.yaml` in your repository. This workflow implements the complete flow:

```yaml
name: DevSecOps Complete Pipeline

on:
  push:
    branches: [ "main" ]

jobs:
  # ================= CI & SECURITY PIPELINE =================
  build-and-security-tests:
    name: Build and Security Scans
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '16'

      - name: 1. Build Application
        run: npm install

      - name: 2. Unit Testing
        run: npm test

      # ----- SECURITY GATES -----
      - name: 3. Secret Scanning (TruffleHog)
        uses: trufflesecurity/trufflehog@main
        with:
          path: ./
          base: ${{ github.event.repository.default_branch }}
          head: HEAD
          extra_args: --debug --only-verified

      - name: 4. SAST - Code Scanning (GitHub CodeQL)
        uses: github/codeql-action/init@v2
        with:
          languages: javascript
      - name: Perform CodeQL Analysis
        uses: github/codeql-action/analyze@v2

      - name: 5. SCA - Dependency Scanning (Snyk or npm audit)
        run: npm audit --audit-level=high

      - name: 6. Build Docker Image
        run: docker build -t my-app:latest .

      - name: 7. Container Image Scan (Trivy)
        uses: aquasecurity/trivy-action@master
        with:
          image-ref: 'my-app:latest'
          format: 'table'
          exit-code: '1' # This is the Security Gate! Fails pipeline if vulnerabilities found.
          ignore-unfixed: true
          vuln-type: 'os,library'
          severity: 'CRITICAL,HIGH'

  # ================= CD PIPELINE =================
  deploy:
    name: Push and Deploy to Kubernetes
    runs-on: ubuntu-latest
    needs: build-and-security-tests # Only runs if ALL security gates pass
    steps:
      - name: Checkout Code
        uses: actions/checkout@v3

      - name: 8. Login to DockerHub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: 9. Push Docker Image
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          tags: ${{ secrets.DOCKERHUB_USERNAME }}/my-app:latest

      - name: 10. Deploy to Kubernetes (Placeholder)
        # Note: In a real environment, you'd use a kubeconfig secret or AWS/GCP credentials here.
        run: |
          echo "Deploying to Kubernetes using manifests..."
          # kubectl apply -f k8s/deployment.yaml
          echo "Deployment successful."
```

---

## 3. Pipeline Execution & Verification

### Deliverables & Screenshots
Once you have pushed your `.github/workflows/devsecops.yaml` to GitHub, drop your screenshots below:

1. **Security Tools Configuration:** Show that you have configured GitHub Advanced Security (CodeQL) or your secrets correctly.
   > *(Insert Screenshot here)*

2. **Pipeline Running:** Show the GitHub Actions tab with the pipeline progressing through the security gates.
   > *(Insert Screenshot here)*

3. **Failed Security Gate (Optional but Recommended):** Intentionally add a high-severity vulnerability to your `package.json` (or hardcode a fake AWS key) and show the pipeline failing.
   > *(Insert Screenshot here showing TruffleHog or Trivy blocking the build)*

4. **Successful Pipeline Output:** Show the green checkmarks across all Build, Security, and Deploy steps.
   > *(Insert Screenshot here)*
