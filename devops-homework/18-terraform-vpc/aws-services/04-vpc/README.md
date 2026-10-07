# AWS VPC - Networking

## What is VPC?
Amazon Virtual Private Cloud (Amazon VPC) lets you provision a logically isolated section of the AWS Cloud where you can launch AWS resources in a virtual network that you define.

## CIDR
Classless Inter-Domain Routing (CIDR) block is a method for allocating IP addresses and IP routing. It defines the IP range for your VPC (e.g., `10.0.0.0/16`).

## Subnets
A subnet is a range of IP addresses in your VPC. You can launch AWS resources into a specified subnet. Subnets map directly to Availability Zones.

## Route Tables
A route table contains a set of rules, called routes, that are used to determine where network traffic from your subnet or gateway is directed.

## Internet Gateway (IGW)
An internet gateway is a horizontally scaled, redundant, and highly available VPC component that allows communication between your VPC and the internet.

## NAT Gateway
Network Address Translation (NAT) Gateway allows instances in a private subnet to connect to services outside your VPC but external services cannot initiate a connection with those instances.

## Security Groups
Stateful virtual firewalls that control inbound and outbound traffic at the ENI (instance) level.

## Network ACLs
Network Access Control Lists (NACLs) are stateless virtual firewalls that control inbound and outbound traffic at the subnet level.

## Public vs Private Subnet
- **Public Subnet:** A subnet whose route table directs internet-bound traffic to the Internet Gateway.
- **Private Subnet:** A subnet whose route table does NOT direct internet-bound traffic to an IGW (often directed to a NAT Gateway instead).
