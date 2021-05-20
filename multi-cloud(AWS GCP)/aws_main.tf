resource  "aws_instance"  "os1" {
ami                 = "ami-010aff33ed5991201"
#instance_type      = var.instance_type
instance_type       = var.types["ap-south-1"]
count               = var.isprod ? 1 : 0
availability_zone   = var.az_name[0]
tags = {
     Name           = "os1 of terraform-provisioner"
     }
}








