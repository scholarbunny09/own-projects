resource "aws_instance" "host" {
  ami = var.AMI_ID
  instance_type = var.INSTANCE_TYPE
  subnet_id = var.PUB_SUBNET
}

resource "aws_instance" "database" {
  ami = var.AMI_ID
  instance_type = var.INSTANCE_TYPE
  subnet_id = var.PRI_SUBNET
  
}