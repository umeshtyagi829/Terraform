resource "aws_volume_attachment" "ebs_att" {
device_name = "/dev/sdh"
volume_id = aws_ebs_volume.st1.id
instance_id = aws_instance.os1.id
}


