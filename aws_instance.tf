module "key_pair" {
  source     = "terraform-aws-modules/key-pair/aws"
  key_name   = "deployer-three"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDJQoC4MRv9Ng/80P9Q6ZybFSztnETaoywaOYJnF8HEv5fOGoNbFoIeOQq3P2PkH14xh/wmMiMb3BAQsbpvRvXO9Zg4u3kjyJF/r251ip75w2p7pm1Rp6CW2L7k6BrJOrxQf8knzzyK1yyGo6WV5cEvxq16rEf5vFwF/0PgeprXPdWhwVSbxu4gDW3KSOHiJr648ZxP8T9rmzYrsAqE7TaQ8h7mcRsegONn3zUTNCB5UHKllDirwDXoA6x3lhGRy9jSmWh+B+KSHK6+TlsxEn3aqKl2h05M3+eG0gCNwWiRCLBKVzxP+Sq9nu3IvnIeHQ0f/9+hEjs0P0ZQKvkddni1 root@ip-172-31-42-1"
  private_key = "-----BEGIN RSA PRIVATE KEY-----
MIIEogIBAAKCAQEAixRVTc1C/pTHkvtDROlBYoxhnIEPRrakr15HWj3qTWuxFiYD
t5iknOKOHIIvjdIAyCp8nV3wywSaW25Hj6i1haofbR3ZtiR0Tjor3x2r40ckBCXx
9frA1X0oL2/cxZWFl/LVP1OKGDc5snFV7Ms+rmdZ+O3KAQIQj9+m6hSDiT4CRLJc
hEsvK91kKDmW2S8CRBNm8x2RtrhJR84XeiDMnqiw+Ybz3Y42ue28pzCPU0HaXQ8a
9fMnJ0+zLqx8bAuG2ApMpUmGOjsabcCi2wLwwtNPdH3eIQF8imlWsX7ty4yX861Y
SNw//l4bYB2+54L82m+88m7i168xVxnqp+NbawIDAQABAoIBAED0biK4CuH7enoa
/3/fsLnl9nCxlgDgrGl7DrgG0rb15O8DMhk9ISRkaxrFcpA51EOoFCsrBJrMu4qY
JrPhh2W13peHqXZ38BnY8URzByROxXNqhWbshcMvgOUmyWU+P/aHYzEAQy6sHDZK
2GaPRecOPecUp5Nw82s+eSY6DnS520AkvN6MiO6Yr3BQOkIAMRMyks5wb0rQATZ1
Mum1hyt8p5aLJznpAARbGZBoXFZgpyaF5YjatC1xPJMGRSmBVMcbbmMhQYpF4src
B5nMM+NTZZbCNLnEOz4fBMFUaSP8Nw70ehDBh7grD5Ec+iFE94VtfP4TS8xki11U
Jmr/VAECgYEA8zHBSUB10MCkqHRnDd20GR4wYT7TNq3W+oGZbQg3c/waMhqm5fel
bO75N37oXU9PZ71R55wy21j6D/ogHWFCx5Nhqo/80JONZIcHL7QKJA9F6occxX3W
95GOcz0FVO9mfYmgwBk1VhyaZk2IIOPJtzNaObFoc4pMqGbLRH5LSQsCgYEAkmcd
h2TxRl8qB4D5HvowNnfjgeHDNxOXeL10JwqqLN3w9lihLU3AsVNcHXvFNiynZQxK
80K7XptNqIXBB0HdPHRMHeE/BU/meazsakVziHTc8X0Jv64QhCZEt48HXCsxQHW6
ntVcCWHxJE9eQUqFz6tTDNv82dOazwucXix9cyECgYBI9yGl57gxhMsiW6Jbz6vs
aVlco+vdGPVKPb4Zr4BrxTTa2ZI/pziz4VNWqjXvYQ9S8cN0OTItC5ojVwlxpy/R
D1AbS44vykV+5uBqGJt+TDLO9fDU9DeeGcbinmlOHXHjsnpPiICvMG/Gx/ZS3+Uy
mS615puPJuxvDkBocXgHFwKBgDDFy2+UsFB6WZ0gWV35iWBL9m4JkShjDX4611w+
UE0cLy9SfXeDRKOOmsxztFKE88tVGg8KdzNgV7HBxXmudo6yS71UkdMqOCTm9+e7
dW7LR+PnfPzvdy8fNJtWOeR5uzG3RtGtULkLePNYwZTMx+FUORm6m/TRaux4+MHi
3nQhAoGAPDBu0mIh912nnMD34tf1xg/w471dNJ0W2WXAbGGpXjN63WgQTGNrBjaf
ZplRY2C1Ua0ge/TvLGAEh5R8uxFMP7De7x4VbTO4bU2QXuapf/HfTeIJJf1Gpkus
ecBrwDSP/EcfCe3Gy4o1pYlYyGbm3fz6l5xNwEKpvUXNVDD5i7A=
-----END RSA PRIVATE KEY-----"
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
