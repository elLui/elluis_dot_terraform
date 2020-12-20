# usually want vpc.id, vpc.cidr_block, vpc.default_security_group_id
output "vpc" {
  value = aws_vpc.elluis_vpc
}

output "public_subnet_ids" {
  value = {for az, subnet in aws_subnet.public : az => subnet.id}
}

output "private_subnet_ids" {
  value = {for az, subnet in aws_subnet.private : az => subnet.id}
}

# Each Public Subnet has the same Route Table
# Have to construct the AZ to public route table output from aws_subnet.public because I cant iterate
# over aws_route_table.public since there is only one
//output "public_route_table_ids" {
//  value = {for az, subnet in aws_subnet.public : az => aws_route_table.public.id}
//}
//
//output "private_route_table_ids" {
//  value = {for az, route_table in aws_route_table.private : az => route_table.id}
//}