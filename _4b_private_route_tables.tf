# keeping both the public and private route tables separate is intentional
# keep them separate ! for heavens sake !

# WARNING: construction zone
# synopsis: i am debating the creating of a nat gateway due to cost considering just creating an rds on the free
# tier for db interaction while still in the network construction phase

/*
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
the following code will resource will call on the gateway provisioner to assign the gateways to each private subnet

disabled to do cost vs stage of development

current strategy is to not use private subnet structure (yet)
instead we will be provisioning an rds instance and serving a command single command ec2 instance

______________________________________________________________________________________________________________________
?? diagram for example only
in this example we would create an db instance in each private subnet to serve the application
in each availability zone
the commented out portions represent the currently commented out functionality described above

-vpc:
-subnets:
  -public_subnet:
    -public_route_tables:
  -private_subnet:
    -private_route_tables:
      #from: nat_gateway to public_subnet
      #from: public_subnet to nat_gateway

  instead (to save money during development) ::
deactivate:
  nat implementation
activate:
  underlying substructure ( private subnets , etc )
  one rds instance that will serve one private subnet us-east-2c

during application development:
  this subnet will have a developer instance for application deployment and delegate rds and web
  server communications

server-us-east2c <----------> developer-instance <----------> rds-instance

______________________________________________________________________________________________________________________
*/


# 1_ create public route table
resource "aws_route_table" "private" {
  for_each = var.azs

  vpc_id = aws_vpc.elluis_vpc.id
  tags = merge(
  local.default_tags,
  {
    Name = format(
    "%s-%s-%s",
    upper(var.env_prefix),
    lookup(var.region_az_short_names, format("%s%s", local.region_name, each.key)),
    local.private_label
    )
  }
  )
}
# 2_ creates route for private subnets
resource "aws_route" "private_subnet_route" {
  for_each = var.azs

  destination_cidr_block = local.route_out_cidr
  route_table_id = lookup(aws_route_table.private, each.key).id
  # connecting the nat gateway to the subnet
  # at the moment I am commenting out this call - due to the fact that I do not want to pay nat gateway prices for 3
  # running nat gateways at this stage of development
  # just in-case of uncomment !!!... will still stop you from trying to connect all the nats!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//  nat_gateway_id = lookup(aws_nat_gateway.elluis_nat_gateway, each.key).id

//  lifecycle {
//    ignore_changes = [
//      route_table_id,
//      nat_gateway_id]
//  }
}

# create aws public out route from all ports
resource "aws_route" "public_route_out_all" {
  # connect to public route table
  route_table_id          = aws_route_table.private.id
  # create out all 0.0.0.0/0 ( passed from _2_ )
  destination_cidr_block  = local.route_out_cidr
  # connect to internet gateway ( created in _3_ )
  gateway_id              = aws_internet_gateway.elluis_internet_gateway.id
}
# create aws public route table association
resource "aws_route_table_association" "public" {
  # for availability availability zone
  for_each                = var.azs
  # the following two lines associate the subnet with the route table and vice versa
  subnet_id               = lookup(aws_subnet.public, each.key).id
  route_table_id          = aws_route_table.public.id
}