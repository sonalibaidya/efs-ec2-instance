resource "aws_instance" "testinstance" {
  ami                         = "ami-05fa00d4c63e32376"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet[0].id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  key_name                    = "new-eks"
  user_data                   = <<-EOF
               #! /bin/bash

               sudo yum install httpd -y

               sudo systemctl start httpd

               sudo systemctl enable httpd

               echo "<h1>Sample Webserver" | sudo tee /var/www/html/index.html
EOF  
  tags = {
    Name = "testinstance"
  }
}