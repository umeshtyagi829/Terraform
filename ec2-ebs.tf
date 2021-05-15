provider "aws"{

region = "ap-south-1"
profile = "user1"
}

resource  "aws_instance"  "os1" {

ami = "ami-010aff33ed5991201"
instance_type = "t2.micro"
tags = {
     Name = "os1 of terraform-provisioner"
     }
}

output "az"{
value = aws_instance.os1.availability_zone
}

output "public_ip"{
value = aws_instance.os1.public_ip
}

resource "aws_ebs_volume" "st1" {
availability_zone = aws_instance.os1.availability_zone
size = 1
tags = {
Name = "HD1"
}
}

output "vol_id"{
value = aws_ebs_volume.st1.id
}

resource "aws_volume_attachment" "ebs_att" {
device_name = "/dev/sdh"
volume_id = aws_ebs_volume.st1.id
instance_id = aws_instance.os1.id
}

output "ebs-attach"{
value = aws_volume_attachment.ebs_att
}
