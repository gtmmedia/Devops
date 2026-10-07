# Kubernetes Homework - Session 16: CI/CD & GitHub Actions

## Introduction to CI/CD Concepts

### CI vs CD
- **Continuous Integration (CI):** The practice of automating the integration of code changes from multiple contributors into a single software project. The CI process involves fetching code, linting, building, and running automated tests.
- **Continuous Deployment / Delivery (CD):** The automated process of pushing the validated code from the CI phase into staging or production environments. Continuous Delivery means the code is ready to be deployed at the click of a button, whereas Continuous Deployment means it happens completely automatically.

### CI/CD Pipeline
A CI/CD pipeline is the sequence of automated steps that take code from version control to production. It guarantees that the code is tested and built consistently every single time a change is pushed.

---

## GitHub Actions Core Concepts

### GitHub Actions
GitHub Actions is a CI/CD platform integrated directly into GitHub that allows you to automate your build, test, and deployment pipeline.

### Workflow
A configurable automated process that will run one or more jobs. Workflows are defined by a YAML file checked into your repository under `.github/workflows/`. They are triggered by events (like a push or pull request).

### Jobs
A workflow run is made up of one or more jobs. By default, jobs run in parallel, but you can configure them to run sequentially (e.g., a `Deploy` job that depends on a `Test` job).

### Steps
A job contains a sequence of tasks called steps. Steps can run commands (like `npm install`) or run pre-built actions (like `actions/checkout@v3`).

### Runners
A server that runs your workflows. GitHub provides Ubuntu Linux, Windows, and macOS runners. You can also host your own runners.

### Secrets
Encrypted environment variables that you create in your GitHub repository settings. They allow you to store sensitive information (like Docker Hub passwords or Cloud API keys) safely without committing them to the code.

### Artifacts
Files created during a workflow run (like compiled binaries or test logs) that you can pass between jobs or download after the workflow finishes.

---

## The Demo Project: Building a Complete Pipeline

For this project, we are automating the Build, Test, and Deployment of our application. 

### 1. Application Source Code & Dockerfile
The source code and the `Dockerfile` are located in the `10-final-cicd-pipeline` directory. Ensure they are pushed to the root of your GitHub repository.

### 2. GitHub Actions Workflow (The Pipeline)
You need to create a file in your repository at `.github/workflows/cicd.yaml`. Here is the complete CI/CD pipeline you should use:

```yaml
name: Complete CI/CD Pipeline

on:
  push:
    branches:
      - main

jobs:
  # ---------------- CI PIPELINE ----------------
  build-and-test:
    name: Build and Test
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '16'

      - name: Install Dependencies
        run: npm install

      - name: Run Tests
        run: npm test

      - name: Upload Test Coverage Artifact
        uses: actions/upload-artifact@v3
        with:
          name: test-coverage
          path: coverage/

  # ---------------- CD PIPELINE ----------------
  deploy:
    name: Build Docker Image and Deploy
    runs-on: ubuntu-latest
    needs: build-and-test # This ensures CD only runs if CI passes
    steps:
      - name: Checkout Code
        uses: actions/checkout@v3

      - name: Login to DockerHub
        uses: docker/login-action@v2
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: Build and Push Docker Image
        uses: docker/build-push-action@v4
        with:
          context: .
          push: true
          tags: ${{ secrets.DOCKERHUB_USERNAME }}/my-app:latest

      # Note: Actual deployment steps (e.g. connecting to server via SSH, or applying kubectl commands) go here.
      - name: Deploy Placeholder
        run: echo "Deploying image ${{ secrets.DOCKERHUB_USERNAME }}/my-app:latest to Production..."
```

### 3. Pipeline Execution
Once you commit and push the `.github/workflows/cicd.yaml` file along with your application code, GitHub Actions will automatically trigger the pipeline.

### Outputs & Screenshots
Follow these steps and drop your screenshots here:

1. **Add Secrets:** Go to your GitHub Repo -> Settings -> Secrets and Variables -> Actions. Add `DOCKERHUB_USERNAME` and `DOCKERHUB_TOKEN`.
   > *(Insert Screenshot of your configured secrets here)*

2. **Trigger the Workflow:** Push the code to the `main` branch.
   > *(Insert Screenshot of the git push terminal output here)*

3. **Successful Execution:** Go to the "Actions" tab in your GitHub repository and watch the pipeline run.
   > *(Insert Screenshot of the green checkmarks on both the 'Build and Test' job and the 'Deploy' job here)*

4. **Artifacts:** Click on the successful workflow run and view the uploaded artifacts at the bottom of the page.
   > *(Insert Screenshot showing the uploaded test-coverage artifact here)*
