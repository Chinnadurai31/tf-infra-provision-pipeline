
resource "aws_instance" "test_instance" {
    for_each = var.ec2_instance
    ami           = each.value.ami_id
    instance_type = each.value.instance_type
    subnet_id     = each.value.subnet_id
    key_name      = each.value.key_name

    instance_market_options {
        market_type = "spot"
    }
    tags = {
        Name = each.key
    }
} 

