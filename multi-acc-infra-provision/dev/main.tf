# -----------------------------------------------------------------------------
# DEV ACCOUNT — Terraform configuration using shared modules
# -----------------------------------------------------------------------------

module "vpc" {
  source = "../../modules/vpc"

  region               = var.region
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  availability_zones   = var.availability_zones
}
#dummy

module "ec2" {
  source = "../../modules/ec2"

  ec2_instance = {
    "Public_instance" = {
      instance_type = var.ec2_instance["Public_instance"].instance_type
      ami_id        = var.ec2_instance["Public_instance"].ami_id
      subnet_id     = module.vpc.public_subnet_ids[0]
      key_name      = var.ec2_instance["Public_instance"].key_name
    }
    "Private_instance" = {
      instance_type = var.ec2_instance["Private_instance"].instance_type
      ami_id        = var.ec2_instance["Private_instance"].ami_id
      subnet_id     = module.vpc.private_subnet_ids[1]
      key_name      = var.ec2_instance["Private_instance"].key_name
    }
  }
}