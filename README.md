# Terraform Multi-Account Infra Provision Pipeline

Reusable Terraform modules (VPC + EC2) deployed across multiple AWS accounts (dev, staging, prod) using GitHub Actions with OIDC authentication.

## How it works

- **PR opened** → auto-runs `terraform plan` for every changed environment. Comments the plan on the PR.
- **Merged to main** → auto-runs `terraform apply` for every changed environment. Each environment pauses for **manual approval** before applying.
- **Shared modules** (`modules/`) changed → triggers plan/apply for **all** environments.

Each environment has its own config directory under `multi-acc-infra-provision/<env>/` with its own `backend.tf`, `terraform.tfvars`, and AWS provider. The GitHub Action dynamically detects which envs changed via `git diff` and fans out using a matrix strategy.

## Prerequisites

### 1. IAM OIDC provider in each AWS account

Create an IAM OIDC Identity Provider:
- Provider URL: `https://token.actions.githubusercontent.com`
- Audience: `sts.amazonaws.com`

Create an IAM role with a trust policy for your repo and attach Terraform permissions (EC2, VPC, etc.).

### 2. GitHub Variables (not Secrets)

Go to **Settings → Secrets & Variables → Actions → Variables** and add:

| Variable | Value |
|---|---|
| `AWS_ROLE_DEV` | `arn:aws:iam::<DEV_ACCOUNT_ID>:role/<role-name>` |
| `AWS_ROLE_STAGING` | `arn:aws:iam::<STAGING_ACCOUNT_ID>:role/<role-name>` |
| `AWS_ROLE_PROD` | `arn:aws:iam::<PROD_ACCOUNT_ID>:role/<role-name>` |

The workflow automatically uppercases the env name (e.g., `dev` → `DEV`) when looking up the variable.

### 3. GitHub Environments (for approval gates)

Go to **Settings → Environments** and create:
- `terraform-apply-dev`
- `terraform-apply-staging`
- `terraform-apply-prod`

Optionally add required reviewers to each environment.

### 4. S3 Backend

Each `multi-acc-infra-provision/<env>/backend.tf` points to its own S3 bucket/prefix so state files stay isolated per environment.