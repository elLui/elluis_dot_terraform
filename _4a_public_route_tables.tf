# create public route table
resource "aws_route_table" "public" {
  vpc_id                    = aws_vpc.elluis_vpc.id
  tags                      = merge(
  local.default_tags,
  {
                # it is important to note that this name will not dynamically - we are only spinning up one igw
                # since we will be attaching the internet gateway will be attached to all public subnets located
                # in the region
    Name                    =  format("%s-%s-%s",
                            upper(var.env_prefix),
                            local.region_short_name,
                            local.public_label
    )
  }
  )
}
# create aws public out route from all ports
resource "aws_route" "public_route_out_all" {
  # connect to public route table
  route_table_id = aws_route_table.public.id
  # create out all 0.0.0.0/0 ( passed from _2_ )
  destination_cidr_block    = local.route_out_cidr
  # connect to internet gateway ( created in _3_ )
  gateway_id                = aws_internet_gateway.elluis_internet_gateway.id
}

# create aws public route table association
resource "aws_route_table_association" "public" {
  # for availability availability zone
  for_each                  = var.azs
  # the following two lines associate the subnet with the route table and vice versa
  subnet_id                 = lookup(aws_subnet.public, each.key).id
  route_table_id            = aws_route_table.public.id
}