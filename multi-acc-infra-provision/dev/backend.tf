# -----------------------------------------------------------------------------
# DEV ACCOUNT — S3 Backend for remote state
# -----------------------------------------------------------------------------

terraform {
  backend "s3" {
    bucket       = "terraform-backend-chinna-123"
    key          = "multi-acc/dev/terraform.tfstate"
    region       = "us-east-2"
    use_lockfile = true
  }
}