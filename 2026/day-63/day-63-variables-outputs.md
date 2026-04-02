# 🚀 Day 63 - Terraform Variables, Outputs & Data Sources

## 📌 1. variables.tf (All Variable Types)

``` hcl
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "Subnet CIDR block"
  type        = string
  default     = "10.0.0.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type        = string
  default     = "dev"
}

variable "allowed_ports" {
  description = "Allowed ports"
  type        = list(number)
  default     = [22, 80, 443]
}

variable "extra_tags" {
  description = "Extra tags"
  type        = map(string)
  default     = {}
}
```

## 📌 2. terraform.tfvars (Dev)

``` hcl
project_name  = "terraweek"
environment   = "dev"
instance_type = "t3.micro"

allowed_ports = [22, 80]

extra_tags = {
  Owner = "Nikhil"
  Env   = "Dev"
}
```

## 📌 3. terraform-prod.tfvars (Prod)

``` hcl
project_name  = "terraweek"
environment   = "prod"
instance_type = "t3.medium"

allowed_ports = [22, 80, 443]

extra_tags = {
  Owner = "Nikhil"
  Env   = "Production"
}
```

## 📌 4. Outputs After terraform apply

    vpc_id                 = "vpc-xxxx"
    subnet_id              = "subnet-xxxx"
    instance_id            = "i-xxxx"
    instance_public_ip     = "x.x.x.x"
    instance_public_dns    = "ec2-xx.compute.amazonaws.com"
    security_group_id      = "sg-xxxx"

## 📌 5. Variable Precedence

1.  Default values\
2.  Environment variables\
3.  tfvars files\
4.  CLI flags

## 📌 6. Useful Functions

-   merge()
-   tostring()
-   tonumber()
-   length()
-   contains()

## 📌 7. Difference

-   variable → input\
-   local → internal\
-   output → result\
-   data → fetch existing
