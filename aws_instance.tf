/* 

resource "tls_private_key" "my_key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "deployer" {
  key_name   = "efs-key"
  public_key = tls_private_key.my_key.public_key_openssh
}
 */


module "key_pair" {
  source     = "terraform-aws-modules/key-pair/aws"
  key_name   = "deployer-three"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC0TLsSPoiOSnac9MqVcaYh+NlJ0cqS4AKlNA9dh5CliG/jyaH1zUH6y4lWlqPBRBQ610UpKMST48cbbRVHYlZ7Suf415/Jp1zjM7NUS7H4USdbLI0qFL7OTHUSyyQBYG565EFsTMdUknVikQM6T2B1Dbs46JoRubfNlKg94YQljNl7inBFiks+/DKxXpcq/p1znvUz/cdWP5C77tXx8RB0vpFLDTSw0jRc/legZ/VdcqSpZJFOION5F+7HkiM5YT3QYFdNuA9khCL+Iqwd2LgcHWF12nFn+TQXvt9yl4VyXeLqc9GQeknGartTRcGc+gyW+3iDNjhdTcjHmBJwlMMSIAbEKW3QT1n3PkiCgH37/Df3GVtGCPVKmo1jnyFHkotSjqnz6ixw7H1IXyOYq2ED9BtLScyc8Za0j+p+D5M5qTGeWaBoiwg1gnXr6QuTzegi/ei2GYSrnNe0vmBEtMj+ctViXvV3TBn783lg+nNafOx00/T1snSH5Q2BvUESDB0= root@ip-172-31-85-18"
}


/* # Saving Key Pair for ssh login for Client if needed
resource "null_resource" "save_key_pair" {
  provisioner "local-exec" {
    command = "echo  ${tls_private_key.my_key.private_key_pem} > mykey.pem"
  }
} */

resource "aws_instance" "testinstance" {
  ami                         = "ami-05fa00d4c63e32376"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet[0].id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  key_name                    = module.key_pair.key_name
  tags = {
    Name = "testinstance"
  }
}