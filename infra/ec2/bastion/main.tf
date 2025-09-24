#Bastion Server구축
resource "aws_instance" "user09-web" {
  ami                         = "ami-077ad873396d76f6a"
  instance_type               = "t2.micro"
  subnet_id                   = element(var.public_subnet_id, 0)
  vpc_security_group_ids      = ["sg-07c87f7d9d107b060"]
  key_name                    = "user09-key"
  associate_public_ip_address = true
  tags = {
    Name = "user09-bastion"
  }
}

