# variable "names" {
#   type = list(string)
#   default = [ "a", "b", "c"]
# }

# resource "local_file" "abc" {
#     count =  length(var.names)
#     content = "abc"
#     filename = "${path.module}/abc-${var.names[count.index]}.txt"
#   }

# resource "local_file" "def" {
#     count =  length(var.names)
#     content = local_file.abc[count.index].content
#     filename = "${path.module}/def-${element(var.names, count.index)}.txt"
#   }
# resource "local_file" "abc" {
#   count = 5
#   content = "abc"
#   filename =  "${path.module}/abc${count.index}.txt"
# }

##for_each
# variable "names" {
#   default = {
#     a = "content a"
#     c = "content c"
#   }

# }

# resource "local_file" "abc" {
#   for_each = var.names
#   content = each.value
#   filename = "${path.module}/${each.key}.txt"
# }

# resource "local_file" "def" {
#   for_each = local_file.abc
#   content = each.value.content
#   filename = "${path.module}/def-${each.key}.txt"
# }

# resource "local_file" "abc" {
#   for_each = toset(["a","b","c"])
#   content = "abc"
#   filename = "${path.module}/abc-${each.key}.txt"
# }

# variable "names" {
#   default = ["a","b","c"]
# }

# resource "local_file" "abc" {
#   content = jsonencode([for s in var.names: upper(s)]) #주어진 값은 문자열로 코딩
#   filename = "${path.module}/abc.txt" 
# }

# variable "names" {
#   type = list(string)
#   default = [ "a","b" ]
# }

# output "A_upper_value" {
#   value = [for v in var.names: upper(v)]
# }

# output "B_index_and_value" {
#   value = [for i, v in var.names: "${i} is ${v}"]
# }

# output "C_make_object" {
#   value = {for v in var.names: v => upper(v)}
# }

# output "D_with_filter" {
#   value = [for v in var.names: upper(v) if v != "a"]
# }

# variable "members" {
#   type = map(object({
#     role = string
#   }))
#   default = {
#     "ab" = { role = "member", group = "dev"}
#     "cd" = { role = "admin", group = "dev"}
#     "ef" = { role = "member", group ="ops"}

#   }
# }

# output "A_to_tuple" {
#   value = [for k, v in var.members: "${k} is ${v.role}"]
# }

# output "B_get_only_role" {
#   value = {
#     for name, user in var.members: name => user.role
#     if user.role == "admin"
#   }
# }

# output "C_group" {
#   value = {
#     for name, user in var.members: user.role => name...
#   }
# }

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  ingress {
    description      = "HTTP"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = [aws_vpc.main.cidr_block]
    ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow tls"
  }
}

