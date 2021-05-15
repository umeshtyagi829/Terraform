resource  "aws_instance"  "os1" {

ami = "ami-010aff33ed5991201"
instance_type = "t2.micro"
tags = {
     Name = "os1 of terraform-provisioner"
     }
}

