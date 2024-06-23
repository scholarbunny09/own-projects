output "VPC_ID" {
    value = aws_vpc.test_vpc.id
}

output "public-subnet" {
    value = aws_subnet.public_subnet.id
  
}

output "private-subnet" {
    value = aws_subnet.private_subnet.id
  
}

output "igw" {
    value = aws_internet_gateway.igw-test.id
  
}