output "vpc_id" {
  description = "ID of the VPC"
  value       = module.networking.vpc_id
}

output "subnet_id" {
  description = "ID of the public subnet"
  value       = module.networking.public_subnet_id
}

output "ec2_instance_id" {
  description = "ID of the EC2 instance"
  value       = module.compute.instance_id
}

output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.compute.public_ip
}

output "ec2_public_dns" {
  description = "Public DNS of the EC2 instance"
  value       = module.compute.public_dns
}

output "security_group_id" {
  description = "ID of the EC2 security group"
  value       = module.compute.security_group_id
}