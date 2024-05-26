variable "aws_region" {
  description = "AWS region to create resources in"
  default     = "ap-south-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "Availability zone for the private subnet"
  default     = "ap-south-1a"
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
  default     = "1.28"
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
  default     = "~/.ssh/your_private_key.pem"
}

variable "public_key" {
  description = "Public key for SSH access"
  default     = "YOUR_PUBLIC_KEY"
}
