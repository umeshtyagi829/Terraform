output "az"{
value = aws_instance.os1.availability_zone
}

output "public_ip"{
value = aws_instance.os1.public_ip
}

output "vol_id"{
value = aws_ebs_volume.st1.id
}

output "ebs-attach"{
value = aws_volume_attachment.ebs_att
}