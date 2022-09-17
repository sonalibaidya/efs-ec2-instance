# Generate new private key
resource "tls_private_key" "my_key" {
  algorithm = "RSA"
}
# Generate a key-pair with above key
resource "aws_key_pair" "deployer" {
  key_name   = "efs-key"
  public_key = tls_private_key.my_key.public_key_openssh
}
# Saving Key Pair for ssh login for Client if needed
resource "null_resource" "save_key_pair" {
  provisioner "local-exec" {
    command = "echo  ${tls_private_key.my_key.private_key_pem} > mykey.pem"
  }
}

resource "aws_instance" "testinstance" {
  ami                         = "ami-05fa00d4c63e32376"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet[0].id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  key_name                    = aws_key_pair.deployer.key_name
  tags = {
    Name = "testinstance"
  }
}


/* provisioner "remote-exec" {
  inline = [
    # Mounting Efs 
    "sudo mount -t nfs -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_file_system.efs.dns_name}:/  /var/www/html",
  ]
} */