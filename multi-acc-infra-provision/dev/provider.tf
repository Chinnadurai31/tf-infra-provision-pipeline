# -----------------------------------------------------------------------------
# DEV ACCOUNT — AWS Provider
# -----------------------------------------------------------------------------
#
# The provider is configured via OIDC from GitHub Actions.
# The role ARN is passed dynamically from GitHub Actions vars/secrets,
# so no hardcoded account IDs here.
#
# For local testing, you can set AWS credentials via environment variables
# or aws CLI profile.

provider "aws" {
  region = var.region
}