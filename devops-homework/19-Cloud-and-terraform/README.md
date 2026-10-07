# Kubernetes Homework - Session 19: Cloud & Terraform in Action

## Task: End-to-End Cloud Infrastructure Project

In this task, we will provision a complete cloud infrastructure on AWS using HashiCorp Terraform.

### Suggested Architecture
```text
Terraform
    |
    ├── VPC (Virtual Private Cloud)
    |
    ├── Subnet (Public Subnet)
    |
    ├── Security Group (Allowing SSH and HTTP traffic)
    |
    ├── EC2 (Web Server Instance)
    |
    └── S3 (Storage Bucket)
```

### Terraform Workflow & Commands
Run the following commands in the folder where your `main.tf` is located. Capture the outputs as you go.

#### 1. Initialization
Downloads the required provider plugins (e.g., AWS) and initializes the backend state.
```bash
terraform init
```
> *(Insert Screenshot of `terraform init` success output here)*

#### 2. Formatting & Validation
Ensures your code is correctly formatted and syntactically valid.
```bash
terraform fmt
terraform validate
```

#### 3. Planning
Generates an execution plan, showing you exactly what resources Terraform will create, modify, or destroy.
```bash
terraform plan
```
> *(Insert Screenshot of `terraform plan` output showing the resources to be added here)*

#### 4. Applying
Executes the plan and physically provisions the resources in your AWS account. It will ask for confirmation (type `yes`).
```bash
terraform apply
```
> *(Insert Screenshot of `terraform apply` completion and output variables here)*

#### 5. Verification (AWS Console)
Go to your AWS Console and verify that the resources (VPC, Subnet, EC2, S3) have been created.
> *(Insert Screenshots of the AWS Console showing the active EC2 instance and S3 bucket here)*

#### 6. Destruction
Tears down all the infrastructure managed by this Terraform project to ensure you do not incur unwanted AWS charges.
```bash
terraform destroy
```
> *(Insert Screenshot of `terraform destroy` completion here)*

---

## Project Structure & Deliverables

Your Terraform project should include the following concepts. If you used the `08-mini-project` folder, ensure these are present:

1. **Terraform Providers:** Defined in `provider.tf` (e.g., `hashicorp/aws`).
2. **Variables:** Declared in `variables.tf` (e.g., region, instance type) to make the code reusable.
3. **Resources:** The actual infrastructure components defined in `main.tf` (VPC, Subnet, EC2, S3).
4. **Outputs:** Defined in `outputs.tf` to print out useful information like the EC2 public IP after `terraform apply`.
5. **Dependencies:** Implicit dependencies (e.g., EC2 depends on Subnet via referencing `aws_subnet.my_subnet.id`) and Explicit dependencies (using `depends_on`).
6. **Terraform State:** Understand that the `.terraform.tfstate` file is the source of truth mapping your code to the real world.
