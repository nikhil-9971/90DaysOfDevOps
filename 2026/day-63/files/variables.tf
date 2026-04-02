variable "aws_region" {
  description = "AWS region where resources will be provisioned"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "this is a vpc cidr"
  default = "10.0.0.0/16"
  type = string
}

variable "subnet_cidr" {
  description = "this is a vpc cidr"
  default = "10.0.0.0/24"
  type = string
}

variable "instance_type" {
  description = "This is instance type"
  type = string
  default = "t3.micro"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "environment" {
  description = "This is contain environmnet"
  type = string
  default = "dev"
}

variable "allowed_ports" {
  description = "List of allowed ports"
  type        = list(number)
  default     = [22, 80, 443]
}

variable "extra_tags" {
  description = "Additional tags for resources"
  type        = map(string)
  default     = {}
}