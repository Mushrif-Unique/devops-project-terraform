# ----------------------------------------
# AWS Region
# ----------------------------------------

variable "aws_region" {
  description = "AWS region where the infrastructure will be deployed"
  type        = string
  default     = "ap-southeast-2"
}


# ----------------------------------------
# VPC Configuration
# ----------------------------------------

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}


# ----------------------------------------
# Public Subnet Configuration
# ----------------------------------------

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}


variable "availability_zone" {
  description = "Availability zone for the public subnet"
  type        = string
  default     = "ap-southeast-2a"
}


# ----------------------------------------
# EC2 Configuration
# ----------------------------------------

variable "instance_type" {
  description = "EC2 instance type for the application server"
  type        = string
  default     = "t3.micro"
}


variable "key_name" {
  description = "AWS EC2 key pair name"
  type        = string
  default     = "devops-project2-key"
}


# ----------------------------------------
# Project Configuration
# ----------------------------------------

variable "project_name" {
  description = "Name of the DevOps project"
  type        = string
  default     = "devops-project2"
}


variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "development"
}