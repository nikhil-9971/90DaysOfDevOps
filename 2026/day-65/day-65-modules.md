# Day 65 - Terraform Modules

## 📁 Custom Module Structure

    modules/
    ├── ec2-instance/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── security-group/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf

------------------------------------------------------------------------

## 🖥️ EC2 Module - variables.tf

``` hcl
variable "ami_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "subnet_id" {
  type = string
}

variable "security_group_ids" {
  type = list(string)
}

variable "instance_name" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}
```

------------------------------------------------------------------------

## ⚙️ EC2 Module - main.tf

``` hcl
resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_group_ids

  associate_public_ip_address = true

  tags = merge({
    Name = var.instance_name
  }, var.tags)
}
```

------------------------------------------------------------------------

## 📤 EC2 Module - outputs.tf

``` hcl
output "instance_id" {
  value = aws_instance.this.id
}

output "public_ip" {
  value = aws_instance.this.public_ip
}

output "private_ip" {
  value = aws_instance.this.private_ip
}
```

------------------------------------------------------------------------

## 🌐 Root main.tf (Custom + Registry Modules)

``` hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "terraweek-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]

  map_public_ip_on_launch = true
}

module "web_sg" {
  source = "./modules/security-group"
  vpc_id = module.vpc.vpc_id
}

module "web_server" {
  source             = "./modules/ec2-instance"
  ami_id             = data.aws_ami.amazon_linux.id
  subnet_id          = module.vpc.public_subnets[0]
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "web"
}

module "api_server" {
  source             = "./modules/ec2-instance"
  ami_id             = data.aws_ami.amazon_linux.id
  subnet_id          = module.vpc.public_subnets[1]
  security_group_ids = [module.web_sg.sg_id]
  instance_name      = "api"
}
```

------------------------------------------------------------------------

## 📸 Screenshot

(Add screenshot of EC2 instances running here)

------------------------------------------------------------------------

## ⚖️ Comparison: Manual VPC vs Module

  Feature        Manual VPC   Registry Module
  -------------- ------------ -----------------
  Code Length    High         Low
  IGW Setup      Manual       Automatic
  Route Tables   Manual       Automatic
  Multi-AZ       Complex      Easy
  Reusability    Low          High

------------------------------------------------------------------------

## 🚀 Five Module Best Practices

1.  Always use variables instead of hardcoding values.
2.  Keep modules small and focused on one responsibility.
3.  Use outputs to expose only required values.
4.  Pin module versions to avoid breaking changes.
5.  Use locals and tags consistently across modules.

------------------------------------------------------------------------

**Generated on:** 2026-04-03
