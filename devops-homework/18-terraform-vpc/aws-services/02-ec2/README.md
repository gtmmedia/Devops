# AWS EC2 - Compute

## What is EC2?
Amazon Elastic Compute Cloud (Amazon EC2) provides scalable computing capacity in the AWS Cloud. It eliminates your need to invest in hardware up front, so you can develop and deploy applications faster.

## AMI
An Amazon Machine Image (AMI) provides the information required to launch an instance. You must specify an AMI when you launch an instance. It includes the OS, application server, and applications.

## Instance Types
EC2 provides a wide selection of instance types optimized to fit different use cases. They comprise varying combinations of CPU, memory, storage, and networking capacity (e.g., General Purpose (t2.micro), Compute Optimized, Memory Optimized).

## Key Pairs
A key pair, consisting of a private key and a public key, is a set of security credentials that you use to prove your identity when connecting to an instance via SSH.

## Security Groups
A security group acts as a virtual firewall for your EC2 instances to control incoming and outgoing traffic.

## EBS
Amazon Elastic Block Store (EBS) provides block-level storage volumes for use with EC2 instances. They are highly available, reliable storage volumes that can be attached to any running instance that is in the same Availability Zone.

## Public vs Private IP
- **Public IP:** Routable from the internet. Used when your instance needs to communicate with the outside world.
- **Private IP:** Routable only within the VPC. Used for internal communication (e.g., between a web server and a database).

## Instance Lifecycle
Instances transition through different states: Pending -> Running -> Stopping -> Stopped -> Shutting-down -> Terminated.

## Common Use Cases
- Hosting a web application.
- Batch processing jobs.
- Running enterprise applications.
