resource "aws_instance" "good-morning" {

  ami = "ami-5b673c34" #Red Hat RHEL V7

  instance_type = "t3.micro"

  availability_zone = "us-east-1"

  security_groups = ["${aws_security_group.morning-ssh-http.name}"]

  key_name = "zoomkey"

  user_data = <<-EOF

               #! /bin/bash

               sudo yum install httpd -y

               sudo systemctl start httpd

               sudo systemctl enable httpd

               echo "<h1>Sample Webserver" | sudo tee /var/www/html/index.html

 EOF


  tags = {

    Name = "webserver"

  }

}