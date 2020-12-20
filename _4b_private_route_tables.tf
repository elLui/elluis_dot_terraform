# keeping both the public and private route tables separate is intentional
# keep them separate ! for heavens sake !


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
  nat_gateway_id = lookup(aws_nat_gateway.elluis_nat_gateway, each.key).id

  lifecycle {
    ignore_changes = [
      route_table_id,
      nat_gateway_id]
  }
}


# create aws public route table association
resource "aws_route_table_association" "private" {
  # for availability availability zone
  for_each                = var.azs
  # the following two lines associate the subnet with the route table and vice versa
  subnet_id               = lookup(aws_subnet.public, each.key).id
  route_table_id          = aws_route_table.public.id
}