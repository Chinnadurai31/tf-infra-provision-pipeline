# -----------------------------------------------------------------------------
# DEV — Environment-specific variable values
# -----------------------------------------------------------------------------

region               = "us-east-1"
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.2.0/24", "10.0.3.0/24"]
private_subnet_cidrs = ["10.0.4.0/24", "10.0.5.0/24"]
availability_zones   = ["us-east-1a", "us-east-1b"]

# EC2 instance config — subnet_id is wired in main.tf from VPC module output
ec2_instance = {
  "Public_instance" = {
    instance_type = "t4g.nano"
    ami_id        = "ami-026fccd88446aa0bf"
    key_name      = "terraform-practice-public-ec2"
  }
  "Private_instance" = {
    instance_type = "t4g.nano"
    ami_id        = "ami-026fccd88446aa0bf"
    key_name      = "terraform-practice-private-ec2"
  }
}