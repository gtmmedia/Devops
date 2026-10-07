# AWS DynamoDB & RDS - Database Services

## DynamoDB

### What is it?
DynamoDB is a fully managed NoSQL database service that provides fast and predictable performance with seamless scalability.

### Core Concepts
- **NoSQL:** Non-relational database, flexible schema.
- **Tables:** Similar to relational tables, a collection of data.
- **Items:** A group of attributes that is uniquely identifiable among all of the other items (like a row in a relational database).
- **Attributes:** A fundamental data element, something that does not need to be broken down any further (like a column).
- **Partition Key:** A simple primary key. DynamoDB uses the partition key's value as input to an internal hash function.
- **Sort Key:** Combined with a partition key to form a composite primary key, allowing data clustering and sorted queries.

### Use Cases
- Serverless web apps.
- Microservices.
- Gaming leaderboards.

---

## RDS (Relational Database Service)

### What is it?
RDS makes it easy to set up, operate, and scale a relational database in the cloud. It automates time-consuming administration tasks such as hardware provisioning, database setup, patching, and backups.

### Core Concepts
- **Relational Database:** Stores data in structured tables with predefined schemas and relationships.
- **Supported Engines:** Amazon Aurora, PostgreSQL, MySQL, MariaDB, Oracle Database, and SQL Server.
- **DB Instances:** An isolated database environment in the cloud.
- **Security:** Controlled via IAM, VPC security groups, and KMS for encryption at rest.
- **Backups:** Automated daily backups and manual snapshots.
- **Multi-AZ:** Synchronously replicates your data to a standby instance in a different Availability Zone for high availability.
- **Read Replicas:** Asynchronously replicated instances to scale out read-heavy database workloads.

### Use Cases
- Traditional web and enterprise applications.
- E-commerce platforms.
- ERP and CRM systems.
