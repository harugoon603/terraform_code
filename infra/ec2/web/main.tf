#단일 WEB Server구축
resource "aws_instance" "user09-web" {
  ami           = "ami-077ad873396d76f6a"
  instance_type = "t2.micro"
  subnet_id     = element(var.private_subnet_id, 0)
  vpc_security_group_ids = ["sg-0519f4dbae8cb59b1",
    "sg-0132286d67b03cf8a",
  "sg-07c87f7d9d107b060"]
  key_name = "user09-key"
  tags = {
    Name = "user09-web"
  }
}
