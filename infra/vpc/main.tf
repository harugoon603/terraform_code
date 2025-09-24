resource "aws_vpc" "user09-vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "user09-vpc"
  }
}

resource "aws_subnet" "user09-public01" {
  vpc_id            = aws_vpc.user09-vpc.id
  cidr_block        = var.public_subnet_cidr[0]
  availability_zone = var.azs[0]

  tags = {
    Name = "user09-public01"
  }
}

resource "aws_subnet" "user09-public02" {
  vpc_id            = aws_vpc.user09-vpc.id
  cidr_block        = var.public_subnet_cidr[1]
  availability_zone = var.azs[1]
  tags = {
    Name = "user09-public02"
  }
}

resource "aws_subnet" "user09-private01" {
  vpc_id            = aws_vpc.user09-vpc.id
  cidr_block        = var.private_subnet_cidr[0]
  availability_zone = var.azs[0]
  tags = {
    Name = "user09-private01"
  }
}
resource "aws_subnet" "user09-private02" {
  vpc_id            = aws_vpc.user09-vpc.id
  cidr_block        = var.private_subnet_cidr[1]
  availability_zone = var.azs[1]
  tags = {
    Name = "user09-private02"
  }
}
#인터넷게이트웨이 생성 
resource "aws_internet_gateway" "user09-igw" {
  vpc_id = aws_vpc.user09-vpc.id

  tags = {
    Name = "user09-igw"
  }
}
#eip생성
resource "aws_eip" "user09-eip" {
  domain = "vpc"
  #depends_on = [ "aws_internet_gateway.user09-igw" ]
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = "user09-eip"
  }
}
#deafault게이트웨이
resource "aws_nat_gateway" "user09-nat-gw" {
  allocation_id = aws_eip.user09-eip.id
  subnet_id     = aws_subnet.user09-public01.id
  depends_on    = ["aws_internet_gateway.user09-igw"]
  tags = {
    Name = "user09-nat-gw"
  }
}

resource "aws_default_route_table" "user09-public-rt" {
  default_route_table_id = aws_vpc.user09-vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.user09-igw.id
  }

  tags = {
    Name = "user09-public-rt"
  }
}

#Public 라우터 연결
resource "aws_route_table_association" "user09-public01-rt-assoc" {
  subnet_id      = aws_subnet.user09-public01.id
  route_table_id = aws_default_route_table.user09-public-rt.id
}

resource "aws_route_table_association" "user09-public02-rt-assoc" {
  subnet_id      = aws_subnet.user09-public02.id
  route_table_id = aws_default_route_table.user09-public-rt.id
}

#Private Route Table생성
resource "aws_route_table" "user09-private-rt" {
  vpc_id = aws_vpc.user09-vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.user09-nat-gw.id
  }
  tags = {
    Name = "user09-private-rt"
  }
}

#private subnet과 Private Route Table 연결
resource "aws_route_table_association" "user09-private01-rt-assoc" {
  subnet_id      = aws_subnet.user09-private01.id
  route_table_id = aws_route_table.user09-private-rt.id
}

resource "aws_route_table_association" "user09-private02-rt-assoc" {
  subnet_id      = aws_subnet.user09-private02.id
  route_table_id = aws_route_table.user09-private-rt.id
}
