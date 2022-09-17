resource "aws_efs_file_system" "efs" {
  creation_token   = "efs"
  performance_mode = "generalPurpose"
  throughput_mode  = "bursting"
  encrypted        = "true"
  tags = {
    Name = "EFS"
  }
}


resource "aws_efs_mount_target" "efs-mt" {
  count           = length(data.aws_availability_zones.available.names)
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.subnet[count.index].id
  security_groups = [aws_security_group.efs.id]
}

# Creating Mount target of EFS
resource "aws_efs_mount_target" "mount" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_instance.testinstance.subnet_id
  security_groups = [aws_security_group.ec2.id]
}

# Creating Mount Point for EFS
resource "null_resource" "configure_nfs" {
  depends_on = [aws_efs_mount_target.mount]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = tls_private_key.my_key.private_key_pem
    host        = aws_instance.testinstance.public_ip
  }
}