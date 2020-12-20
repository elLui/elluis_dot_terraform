
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.elluis_vpc.id
  tags = merge(
  local.default_tags,
  {
    Name =  format("%s-%s-%s",
            upper(var.env_prefix),
            local.region_short_name,
            local.public_label
    )
  }
  )
}