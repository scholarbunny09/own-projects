module "VPC" {
    source = "../modules/VPC"
    VPC_ID = var.VPC_ID
    PUB_SUBNET = var.PUB_SUBNET
    PRI_SUBNET = var.PRI_SUBNET
    
}

module "EC2" {
    source = "../modules/EC2"
    AMI_ID = var.AMI_ID
    INSTANCE_TYPE = var.INSTANCE_TYPE
    KEY_NAME = var.KEY_NAME
    PRI_SUBNET = var.PRI_SUBNET
    VPC_ID = var.VPC_ID
    PUB_SUBNET = var.PUB_SUBNET
  
}