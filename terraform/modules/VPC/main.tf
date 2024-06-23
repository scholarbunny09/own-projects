resource "aws_vpc" "test_vpc" {
  cidr_block = var.VPC_ID
}

resource "aws_internet_gateway" "igw-test" {
  vpc_id = aws_vpc.test_vpc.id

  tags = {
    Name = "igw_test"
  }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.test_vpc.id
    cidr_block = var.PUB_SUBNET
    availability_zone = "ap-south-1a"
  
}

resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.test_vpc.id
    cidr_block = var.PRI_SUBNET
    availability_zone = "ap-south-1b"
  
}

resource "aws_route_table" "RT_public" {
  vpc_id = aws_vpc.test_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-test.id
  }

  tags = {
    Name = "RT-public"
  }
}

resource "aws_route_table_association" "public-asociate" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.RT_public.id
}

resource "aws_eip" "nat_ip" {
  domain   = "vpc"
  depends_on = [aws_internet_gateway.igw-test]
}

resource "aws_nat_gateway" "NAT-test" {
  allocation_id = aws_eip.eip-test.id
  subnet_id     = aws_subnet.public_subnet

  tags = {
    Name = "gw NAT"
  }
}
resource "aws_route_table" "RT-private" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT-test.id
  }
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_route_table_association" "private-asociate" {
  subnet_id = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.RT-private.id
}