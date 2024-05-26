provider "aws" {
  region = var.aws_region
}

# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = var.vpc_cidr_block

  tags = {
    Name = "my-vpc"
  }
}

# Create private subnets
resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnet_cidr_block_1
  availability_zone = var.availability_zone_1

  tags = {
    Name = "private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.private_subnet_cidr_block_2
  availability_zone = var.availability_zone_2

  tags = {
    Name = "private-subnet-2"
  }
}

# Create EKS cluster
resource "aws_eks_cluster" "my_cluster" {
  name     = var.cluster_name
  role_arn = var.eks_cluster_role_arn

  version = var.eks_version

  vpc_config {
    subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]
  }
}

# Create IAM role for EKS worker nodes
resource "aws_iam_role" "eks_worker_role" {
  name = "eks-worker-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Attach IAM policies to the worker role
resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_worker_role.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_worker_role.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_worker_role.name
}

# Create EKS worker nodes
resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = "my_node_group"
  node_role_arn   = aws_iam_role.eks_worker_role.arn
  subnet_ids      = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
}

# Create EC2 instance
resource "aws_instance" "my_instance" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update
              chmod 700 ~/.ssh
              chmod 600 ~/.ssh/authorized_keys
              EOF

  tags = {
    Name = "my-instance-${count.index + 1}"
  }
}

# Paste public key in authorized_keys file of newly created EC2 instances
resource "null_resource" "copy_ssh_keys" {
  depends_on = [aws_instance.my_instance]

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      host        = aws_instance.my_instance[count.index].public_ip
      user        = var.ssh_user
      private_key = file(var.private_key_path)
    }

    inline = [
      "echo '${var.public_key}' >> ~/.ssh/authorized_keys"
    ]
  }

  count = var.instance_count
}
