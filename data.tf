data "aws_ami" "output" {

  most_recent = true


  owners = ["self"]

  tags = {

    Name = "app-server"

    Tested = "true"

  }

}