
resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    "Name" = "MY-VPC"
  }
}

resource "aws_subnet" "pubsub" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = var.azs
  map_public_ip_on_launch = true
  tags = {
    "Name" = "MY-PUBLIC-SUBNET"
  }
}
resource "aws_subnet" "prisub" {
  vpc_id                  = aws_vpc.my-vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = var.azs
  map_public_ip_on_launch = false
  tags = {
    "Name" = "MY-PRIVATE-SUBNET"
  }
}


resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    "Name" = "MY-IGW"
  }
}

resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "MY-PUBLIC-RT"
  }
}


resource "aws_route_table_association" "Public-RT-Association" {
  subnet_id      = aws_subnet.pubsub.id
  route_table_id = aws_route_table.public-rt.id
}

