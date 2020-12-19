resource "aws_vpc" "elluis_vpc" {
  cidr_block = var.elluis_codes_vpc_cidr_block
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support
  enable_classiclink               = var.enable_classiclink

  tags = {
    Name = var.tags
  }
}

resource "aws_internet_gateway" "elluis_internet_gateway" {
  vpc_id = aws_vpc.elluis_vpc.id
  tags = {
    Name = "elluis-internet-gateway"
  }
}

resource "aws_subnet" "elluis_subnet_public_1" {
  cidr_block = "64.0.0.0/19"
  vpc_id = aws_vpc.elluis_vpc.id
  map_public_ip_on_launch = true
  tags = {
    Name = "elluis_subnet_public_1"
  }
}