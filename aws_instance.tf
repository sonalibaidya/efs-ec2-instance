module "key_pair" {
  source     = "terraform-aws-modules/key-pair/aws"
  key_name   = "deployer-three"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJQoC4MRv9Ng/80P9Q6ZybFSztnETaoywaOYJnF8HEv5fOGoNbFoIeOQq3P2PkH14xh/wmMiMb3BAQsbpvRvXO9Zg4u3kjyJF/r251ip75w2p7pm1Rp6CW2L7k6BrJOrxQf8knzzyK1yyGo6WV5cEvxq16rEf5vFwF/0PgeprXPdWhwVSbxu4gDW3KSOHiJr648ZxP8T9rmzYrsAqE7TaQ8h7mcRsegONn3zUTNCB5UHKllDirwDXoA6x3lhGRy9jSmWh+B+KSHK6+TlsxEn3aqKl2h05M3+eG0gCNwWiRCLBKVzxP+Sq9nu3IvnIeHQ0f/9+hEjs0P0ZQKvkddni1 root@ip-172-31-42-1
"
}


resource "aws_instance" "testinstance" {
  ami                         = "ami-05fa00d4c63e32376"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.subnet[0].id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  key_name                    = "deployer-three"
  tags = {
    Name = "testinstance"
  }
}
