
# Creating Elastic IP
resource "aws_eip" "nat_eip" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name = "NAT Gateway ID"
  }

}
# Creating Nat Gateway

resource "aws_nat_gateway" "nat-gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.pubsub.id


  tags = {
    Name = "NAT"
  }

}

# Add routes for VPC
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gw.id
  }
  tags = {
    Name = "private RT"
  }
}
# Creating route associations for private Subnets
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.prisub.id
  route_table_id = aws_route_table.private-rt.id
}
