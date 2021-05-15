provider "aws"{
                region  = "ap-south-1"
                profile = "user1"
}

resource "aws_security_group" "allow_web" {
  name        = "allow_web"
  description = "Allow HTTP inbound traffic"
  vpc_id      =  "vpc-83d232e8"
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
   ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
}

output "sgname"{
value = aws_security_group.allow_web.name
}

resource  "aws_instance"  "os1" {
ami = "ami-010aff33ed5991201"
instance_type = "t2.micro"
security_groups = ["allow_web"]
key_name = "awskey"
tags = {
     Name = "os1 of terraform-provisioner"
     }
}

output "public_ip"{
value = aws_instance.os1.public_ip
}

resource "aws_ebs_volume" "st1" {
availability_zone = aws_instance.os1.availability_zone
size = 1
tags = {
Name = "Volume-1"
}
}



resource "aws_volume_attachment" "ebs_att" {
device_name = "/dev/sdh"
volume_id = aws_ebs_volume.st1.id
instance_id = aws_instance.os1.id
}



resource "null_resource" "config_httpd" {
connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/lenovo/Downloads/awskey.pem")
    host     = aws_instance.os1.public_ip
  }

  provisioner "remote-exec" {
    inline = [
        "sudo yum install httpd -y",
        "sudo yum install php -y",
        "sudo systemctl start httpd",
        "sudo systemctl enable httpd"
        ]
  }
}

resource "null_resource" "mount" {
connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/lenovo/Downloads/awskey.pem")
    host     = aws_instance.os1.public_ip
  }

  provisioner "remote-exec" {
    inline = [
        "sudo mk.ext4 /dev/xdvh ",
        "sudo mount /dev/xdvh  /var/www/html"
      
      ]
  }
}

resource "null_resource" "deploy" {
connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("C:/Users/lenovo/Downloads/awskey.pem")
    host     = aws_instance.os1.public_ip
  }

  provisioner "remote-exec" {
    inline = [
        "sudo yum install git -y ",
        "sudo sudo git clone https://github.com/umeshtyagi829/opneshift-github.git  /var/www/html/web"
      
      ]
  }
}
