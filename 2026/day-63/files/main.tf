
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  name_prefix = "${var.project_name}-${var.environment}"
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}

#VPC
resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr

  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-VPC"
  })
}


#Public Subnet
resource "aws_subnet" "my_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.subnet_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true


  tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-public-subnet"

  })
}

#Internet Gatway
resource "aws_internet_gateway" "my_IGW" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "${var.project_name} IGW" # IGW means Internet Gateway
  }
}

#Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_IGW.id
  }

  tags = {
    Name = "${var.project_name}-Public-RT"
  }
}

# Route Table Associate

resource "aws_route_table_association" "my_RTA" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.public_rt.id
}


#Added Security Group

resource aws_security_group my_security_group {

name="${var.project_name}-SG"
vpc_id= aws_vpc.my_vpc.id  # interpolation
description = "this is Inbound and outbound rules for your instance Security group"

}

# Inbound & Outbount port rules



resource aws_vpc_security_group_ingress_rule allow_http {
  for_each = {
    for port in var.allowed_ports : port => port
  }
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = each.value
  ip_protocol       = "tcp"
  to_port           = each.value
}

# resource aws_vpc_security_group_ingress_rule allow_ssh {
#   for_each = {
#     for port in var.allowed_ports : port => port
#   }
#   security_group_id = aws_security_group.my_security_group.id
#   cidr_ipv4         = "0.0.0.0/0"
#   from_port         = each.value
#   ip_protocol       = "tcp"
#   to_port           = each.value
# }


resource aws_vpc_security_group_egress_rule allow_all_traffic {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}


# EC2 INSTANCE

resource aws_instance my_instance {

	ami = data.aws_ami.amazon_linux.id # OS AMI ID

	instance_type = var.instance_type # Instance Type

    subnet_id = aws_subnet.my_subnet.id

	vpc_security_group_ids = [aws_security_group.my_security_group.id] # VPC & Security Group
	
	associate_public_ip_address = true

      lifecycle {
  create_before_destroy = true
}

	tags = merge(local.common_tags, {
    Name = "${local.name_prefix}-Server"
  })

}

#s3 Bucket


resource "aws_s3_bucket" "app_logs" {
  bucket = "terraweek-app-logs-12345736" # must be globally unique

  depends_on = [aws_instance.my_instance]

  tags = {
    Name = "${var.project_name}-Logs"
  }
}