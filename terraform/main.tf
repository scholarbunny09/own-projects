resource "aws_vpc" "main" {
  cidr_block       = var.aws_vpc
  instance_tenancy = "default"

  tags = {
    Name = "test09"
  }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "Test09"
    }
  
}
resource "aws_subnet" "public_subnet_A" {
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.availability_zonea

  tags = {
    Name = "Public Subnet A"
  }
}

resource "aws_subnet" "public_subnet_B" {
    vpc_id = aws_vpc.main.id
    cidr_block = "10.0.2.0/24"
    availability_zone = var.availability_zoneb

    tags = {
      Name = "Public Subnet B"
    }
  
}
 resource "aws_route_table" "public_subnet_route" {
    vpc_id = aws_vpc.main.id

    route = {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
      Name = "Public subnet routing table"
    }
 }

 resource "aws_route_table_association" "a" {
    subnet_id = aws_subnet.public_subnet_A.id
    route_table_id = aws_route_table.public_subnet_route.id
 }

 resource "aws_route_table_association" "b" {
    subnet_id = aws_subnet.public_subnet_B.id
    route_table_id = aws_route_table.public_subnet_route.id
   
 }