//resource "aws_vpc" "elluis_vpc" {
//  cidr_block = var.elluis_codes_vpc_cidr_block
//  instance_tenancy                 = var.instance_tenancy
//  enable_dns_hostnames             = var.enable_dns_hostnames
//  enable_dns_support               = var.enable_dns_support
//  enable_classiclink               = var.enable_classiclink
//  tags = {
//    Name = var.tags
//  }
//}
//
//# query all available zones
//data "aws_availability_zone" "available" {}
//
//# create internet gateway
//resource "aws_internet_gateway" "elluis_internet_gateway" {
//  vpc_id = aws_vpc.elluis_vpc.id
//  tags = {
//    Name = "elluis-internet-gateway"
//  }
//}
//
//# fetch aws eip
//resource "aws_eip" "elluis_eip" {
//  vpc = true
//}
//
////# create nat gateway
////resource "aws_nat_gateway" "elluis_nat_gateway" {
////  allocation_id = aws_eip.elluis_eip.id
////  subnet_id = "${aws_}"
////}
//
//# public subnet
//resource "aws_subnet" "elluis_public_subnet" {
//  vpc_id = aws_vpc.elluis_vpc.id
//  # cidrsubnets - takes the given vpc cidr_block and changes the mask ie 64.0.0.0/16 == 65_536 ip addresses
//  # current planned outlook:
//  # have 16 subnets capable of 2048 hosts with a mask prefix of 20
//  # cidrsubnet(_1_ip_range, _2_new_bits, _3_net_num)
//  # _1_ pass in the value of the vpc cidr_block == 64.0.0.0/16
//  # _2_ calculate new_bit by finding the difference of prefix_20 - vpc_cidr_block_range_16 == 4
//  # _3_ pass in the counter to assign a new ip address in calculated range
//  # since we are attempting to break the total cidr_block range 65_536 ips into 16 separate ranges
//  # if we give cidrsubnet(vpc_cidr_block, 4, count.index)
//  cidr_block = cidrsubnets(var.elluis_codes_vpc_cidr_block, 4, count.index)
//  count = length(data.aws_availability_zone.available.name)
//  availability_zone = data.aws_availability_zone.available.name[count.index]
//
//  tags = {
//    Name = "elluis_public_subnet.${count.index + 1}"
//  }
//}
//
//# private subnet
//resource "aws_subnet" "elluis_private_subnet" {
//  vpc_id = aws_vpc.elluis_vpc.id
//
//  cidr_block = cidrsubnet(var.elluis_private_cidr, 5, count.index)
//  count = length(data.aws_availability_zone.available.name)
//  availability_zone = data.aws_availability_zone.available.name[count.index]
//
//  tags = {
//    Name = "elluis_private_subnet.${count.index + 1}"
//  }
//}
//
//
//
//resource "aws_route_table" "elluis_public_subnet_route_table" {
//  vpc_id = aws_vpc.elluis_vpc.id
//  route {
//    cidr_block = "0.0.0.0/0"
//    gateway_id = aws_internet_gateway.elluis_internet_gateway.id
//  }
//  tags = {
//    Name = "elluis_public_subnet_route_table"
//  }
//}
//
//resource "aws_default_route_table" "elluis_private_subnet_route_table" {
//  vpc_id = aws_vpc.elluis_vpc.id
//  default_route_table_id = aws_vpc.elluis_vpc.default_route_table_id
//
//  route {
//    nat_gateway_id = aws
//  }
//  tags = {
//    Name = "elluis_private_subnet_route_table"
//  }
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//# going to go ahead and hardcode my cidr_blocks to ensure faultless coverage in us-east-2
//
//
////// this will find all available zones selected region
////data "aws_availability_zone" "available" {}
////
////resource "aws_subnet" "elluis_public_subnet" {
////  count = length(data.aws_availability_zone.available.name)
////  vpc_id = aws_vpc.elluis_vpc.id
////  cidr_block = "64.0.${10+count.index}.0/19"
////  availability_zone = "${data.aws_availability_zone.available.name[count.index]}"
////
////  map_public_ip_on_launch = true
////  tags = {
////    Name = "elluis_subnet_public_${data.aws_availability_zone.available.name[count.index]}"
////  }
////}
////
////resource "aws_subnet" "elluis_private_subnet" {
////  count = length(data.aws_availability_zone.available.name)
////  vpc_id = aws_vpc.elluis_vpc.id
////  cidr_block = "64.0.${20+count.index}.0/19"
////  availability_zone = data.aws_availability_zone.available.name[count.index]
////
////  map_public_ip_on_launch = false
////  tags = {
////    Name = "elluis_subnet_private_${data.aws_availability_zone.available.name[count.index]}"
////  }
////}