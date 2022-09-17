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



# Creating Mount Point for EFS
resource "null_resource" "configure_nfs" {
  depends_on = [aws_efs_mount_target.efs-mt]
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = module.key_pair.private_key_pem
    host        = aws_instance.testinstance.public_ip
  }


  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd php git -y -q ",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo yum install nfs-utils -y -q ", # Amazon ami has pre installed nfs utils
      # Mounting Efs 
      "sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs.dns_name}:/  /var/www/html",
    ]
  }
}