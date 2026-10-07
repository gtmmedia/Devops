# AWS S3 - Storage

## What is S3?
Amazon Simple Storage Service (Amazon S3) is an object storage service offering industry-leading scalability, data availability, security, and performance.

## Buckets
A bucket is a container for objects stored in Amazon S3. Every object is contained in a bucket. Bucket names must be globally unique across all of AWS.

## Objects
Objects are the fundamental entities stored in Amazon S3. An object consists of object data and metadata.

## Storage Classes
Amazon S3 offers a range of storage classes designed for different use cases:
- **S3 Standard:** For frequently accessed data.
- **S3 Intelligent-Tiering:** For data with unknown or changing access patterns.
- **S3 Standard-IA:** For long-lived, infrequently accessed data.
- **S3 Glacier:** For long-term archive.

## Versioning
Versioning allows you to keep multiple variants of an object in the same bucket. You can use it to preserve, retrieve, and restore every version of every object stored in your buckets.

## Lifecycle Policies
Lifecycle rules define actions that you want Amazon S3 to take during an object's lifetime (e.g., transitioning objects to a cheaper storage class after 30 days, or expiring them after a year).

## Encryption
S3 supports both Server-Side Encryption (where S3 encrypts data as it writes it to disks) and Client-Side Encryption.

## Bucket Policies
Bucket policies are JSON-based access policy documents attached to S3 buckets that provide centralized access control to the bucket and its objects.

## Common Use Cases
- Backup and restore.
- Hosting static websites.
- Data lakes and big data analytics.
