# ByteByteGo System Architecture on AWS (Terraform + Kubernetes + GitLab)



This project implements a fully cloud-native architecture using:
- **Terraform** for infrastructure (EKS, RDS, Redis, ALB, S3, API Gateway)
- **Helm** for Kubernetes app deployments
- **GitLab CI/CD** for full automation
- **Best practices** in modular infrastructure, IaC, and CI pipelines

---

 Architecture Overview

| Component        | Technology         |
|------------------|--------------------|
| Compute          | Amazon EKS         |
| Networking       | VPC, ALB, Ingress  |
| CI/CD            | GitLab CI/CD       |
| Storage          | S3, RDS (Postgres) |
| Caching          | ElastiCache Redis  |
| Gateway Layer    | API Gateway + ALB  |
| App Layers       | Frontend, Backend, Media Processor, Fanout Services

---

##  Project Structure

```
bytebytego-infra/
├── infra/                     # Terraform infrastructure
├── k8s/helm-charts/          # Helm charts per microservice
├── .gitlab-ci.yml            # GitLab CI automation
└── README.md
```

---

## Deployment Instructions

###  Prerequisites

- AWS CLI and IAM permissions for `eks`, `ec2`, `rds`, `iam`, `s3`
- Terraform installed (`>= 1.5`)
- GitLab project configured with secrets
- Pre-create:
  - `S3` bucket: `bytebytego-terraform-state`
  - `DynamoDB` table: `terraform-locks` (for TF locking)

###  GitLab CI/CD Variables

Set these in **GitLab → Settings → CI/CD → Variables**:

| Key                     | Value                        |
|-------------------------|------------------------------|
| `AWS_ACCESS_KEY_ID`     | Your AWS IAM key             |
| `AWS_SECRET_ACCESS_KEY` | Your AWS IAM secret          |
| `AWS_REGION`            | `us-east-1`                  |
| `TF_VAR_project_name`   | `bytebytego-app`             |

---
create  below secrets using kubeenetes cli

Backend DB password

Stripe API key

Redis credentials


## Accessing the App

- Frontend: http://ALB-DNS/
- Backend API: http://ALB-DNS/api
- Optional: https://API-GW.execute-api.us-east-1.amazonaws.com/prod

1. Define Functional & Non-Functional Requirements First
Functional Requirements:

- Request-response system over HTTP/S.

- Upload and stream media (video, audio, etc.).

- Handle real-time chat/stream.

- Notification, analytics, search, payment, recommendation, etc.

Non-Functional Requirements:

- High Availability (HA)

- Low Latency

- Horizontal Scalability

- Security
  
2. Apply Architecture Principles & Patterns
   
- Microservices: Separated components like authentication, ID generation, message processing.

- Event-driven: Message queues and pub/sub systems.

- Separation of Concerns: API Gateway, Frontend, Backend, CDN, Object Storage, etc.

- Caching: RAM + Distributed Cache for performance boost.

- Load Balancing: Across frontends and backends.

3. Include Capacity Planning & Sizing (Optional)

- Horizontal scaling: Through load balancers, CDN, microservices.

- Partitioning : At the database level.

- Auto-scaling: Backend workers, message processors.

- Monitoring & Metrics: Captured at API Gateway and services.

4. Structure with Clear Architecture Layers


- Client Layer: End-user device requesting via browser/app.

- DNS & CDN Layer: Resolves domain, serves static content globally.

- API Gateway Layer: Validates, throttles, routes requests.

- Frontend Layer: Handles UI logic, real-time connections.

- Backend Layer: Core business logic (auth, metadata, streaming).

- Storage Layer: Databases, caches, object storage.

- Async Layer: Queues, workers, and pub/sub for non-blocking operations.

- Fan-out Services: Notifications, analytics, payments, etc.

5. End with Operational Excellence
- Observability: Logs, metrics, alerts for all services.

- Retries/Timeouts: Message queue and worker design.

- Security: TLS, AuthN/Z, token validation, input validation.

- Data Integrity: Checksums, DB replicas, audit trail.

- Resilience: distributed locking, fallback strategies.



