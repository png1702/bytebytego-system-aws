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





