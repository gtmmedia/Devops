# AWS IAM - Governance

## What is IAM?
AWS Identity and Access Management (IAM) enables you to manage access to AWS services and resources securely. You can create and manage AWS users and groups, and use permissions to allow and deny their access to AWS resources.

## Users
An IAM user is an entity that you create in AWS to represent the person or application that uses it to interact with AWS. A user consists of a name and credentials (a password for console access, and access keys for programmatic access).

## Groups
An IAM group is a collection of IAM users. Groups let you specify permissions for multiple users, which can make it easier to manage the permissions for those users.

## Roles
An IAM role is similar to an IAM user, in that it is an AWS identity with permission policies that determine what the identity can and cannot do in AWS. However, instead of being uniquely associated with one person, a role is intended to be assumable by anyone who needs it, or by AWS services like EC2.

## Policies & Permissions
A policy is an object in AWS that, when associated with an identity or resource, defines their permissions. Policies are stored as JSON documents specifying the Effect (Allow/Deny), Action, and Resource.

## Least Privilege
The security principle of granting users only the permissions they need to complete their tasks and no more.

## IAM Best Practices
1. Delete your root access keys.
2. Require MFA (Multi-Factor Authentication).
3. Use groups to assign permissions.
4. Grant least privilege.
5. Use IAM roles for applications running on EC2 instances.
6. Rotate credentials regularly.

## Common Use Cases
- Allowing developers to launch EC2 instances.
- Allowing an EC2 instance to read from an S3 bucket (using a Role).
- Granting a third-party auditor read-only access to your AWS environment.
