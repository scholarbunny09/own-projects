output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.my_vpc.id
}

output "private_subnet_id" {
  description = "ID of the created private subnet"
  value       = aws_subnet.private_subnet.id
}

output "eks_cluster_name" {
  description = "Name of the created EKS cluster"
  value       = aws_eks_cluster.my_cluster.name
}

output "eks_cluster_endpoint" {
  description = "Endpoint of the created EKS cluster"
  value       = aws_eks_cluster.my_cluster.endpoint
}

output "ec2_instance_ids" {
  description = "IDs of the created EC2 instances"
  value       = aws_instance.my_instance[*].id
}
