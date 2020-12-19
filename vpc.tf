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