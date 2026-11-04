# -----------------------------------------------------------------------------
# DEV ACCOUNT — S3 Backend for remote state
# -----------------------------------------------------------------------------

terraform {
  backend "s3" {
    bucket       = "macrobowl"
    key          = "dev/terraform.tfstate"
    region       = "ap-southeast-1"
    use_lockfile = true
  }
}