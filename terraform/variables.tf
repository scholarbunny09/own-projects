variable "aws_region" {
  description = "AWS region to create resources in"
  default     = "ap-south-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidr_block_1" {
  description = "CIDR block for the private subnet"
  default     = "10.0.1.0/24"
}
variable "private_subnet_cidr_block_2" {
  description = "CIDR block for the private subnet"
  default     = "10.0.2.0/24"
}

variable "availability_zone_1" {
  description = "Availability zone for the private subnet"
  default     = "ap-south-1a"
}
variable "availability_zone_2" {
  description = "Availability zone for the private subnet"
  default     = "ap-south-1b"
}

variable "cluster_name" {
  description = "Name of the EKS cluster"
  default     = "my-eks-cluster"
}

variable "eks_cluster_role_arn" {
  description = "ARN of the EKS cluster role"
  default     = "arn:aws:iam::767397824843:role/amazon_eks_cluster_policy"
}

variable "eks_version" {
  description = "Version of the EKS cluster"
  default     = "1.29"
}

variable "eks_worker_role_arn" {
  description = "ARN of the EKS worker role"
  default     = "arn:aws:iam::767397824843:role/worker_node_policy"
}

variable "instance_types" {
  description = "Instance types for the EKS worker nodes"
  type        = list(string)
  default     = ["t2.micro"]
}

variable "desired_capacity" {
  description = "Desired capacity of the EKS worker nodes"
  default     = 3
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  default     = 2
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  default     = "ami-0cc9838aa7ab1dce7"
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  default     = "t2.micro"
}

variable "ssh_user" {
  description = "SSH user for the EC2 instances"
  default     = "ec2-user"
}

variable "private_key_path" {
  description = "Path to the private key for SSH access"
  default     = "/home/ec2-user/own-projects/terraform/my-key-pair.pem"
}

variable "public_key" {
  description = "Public key for SSH access"
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC2436KgiOoINcxX2M6HYA171K29YvSEIPzj5sY96w6b3kRoKz8UBiQQPS+imwb71TBfcP6YVFCluygQTN4qbsLkWPO7kgubWwS55iUggsr3rrzy4W4SQlxLwSLFD/UlZCJ8OsHM3/pj6fDKkKRNO4l1eUyUCpPKT9vdgxgAm6qLWDntr1SGEZiLwFRCjSYHxjXXqaGSiUCITIUUzaEi/NnrLNdkjGaGoV1p/f5WfDHtibRLJgGNBCxVN7h/IaxcbgnhSV8Bt+eL4fIfbd6kBvH3PeyPfquYk+wWc0G6CsecrIgUcV2IrOO2ET9H1xuVjNBeYXsoH4SHOdSXu7K6n7cSogSjL7vOgHXyG4rGNxn/FWgq5jjiGfFhhdGzVKGH3nJ7tkHdk0HODghTT9WMfYhNpEeBzhhMPh5Byub9VvIHkRnqW1FjSS2KgAI7zRlsMzRHGESSuqzsrDcNalw6Jw8FcecqJ2LPBqw6kQP0Cm88ExjeFm8vvn8u1vhi6RxQ0X4S7AW4SBX3ZDwUY28nQPVQAlGPk47gKsP9cWlEbwbAx5QH9CLWWK0+QzwY5CKD4DfaM5aRGNBtqUYHJPysbJt094Qw+hI+9+GXPd2Xeyr8QTxdQ8SMkF9T1XCsftSqySQuRy7lpGOn76cNcNmLjkn8VU2F8YIL1ARjvEmaYlRSQ== ec2-user@ip-172-31-37-165.ap-south-1.compute.internal"
}
