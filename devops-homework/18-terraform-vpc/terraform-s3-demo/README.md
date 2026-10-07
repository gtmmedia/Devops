# Task 1: Terraform S3 Demo Workflow

This directory contains the Terraform configuration to provision an Amazon S3 bucket. Below is the full workflow documentation you need to execute. Run the commands in your terminal and replace the placeholders below with your screenshots.

### 1. `terraform init`
- **What it does:** Initializes the working directory containing Terraform configuration files. This is the first command that should be run after writing a new Terraform configuration. It downloads the necessary provider plugins (e.g., AWS).
> *(Insert Screenshot here)*

### 2. `terraform fmt`
- **What it does:** Rewrites Terraform configuration files to a canonical format and style.
> *(Insert Screenshot here)*

### 3. `terraform validate`
- **What it does:** Validates the configuration files in a directory, referring only to the configuration and not accessing any remote services such as remote state, provider APIs, etc.
> *(Insert Screenshot here)*

### 4. `terraform plan`
- **What it does:** Creates an execution plan. Terraform performs a refresh, unless explicitly disabled, and then determines what actions are necessary to achieve the desired state specified in the configuration files.
> *(Insert Screenshot here)*

### 5. `terraform apply`
- **What it does:** Executes the actions proposed in a Terraform plan to create, update, or destroy infrastructure.
> *(Insert Screenshot here)*

### 6. `terraform show`
- **What it does:** Used to provide human-readable output from a state or plan file.
> *(Insert Screenshot here)*

### 7. `terraform output`
- **What it does:** Extracts the value of an output variable from the state file.
> *(Insert Screenshot here)*

### 8. `terraform destroy`
- **What it does:** Destroys all remote objects managed by a particular Terraform configuration.
> *(Insert Screenshot here)*
