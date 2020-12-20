/*TODO ::
create a new _60_vpc_command_variables.tf :: this will contain
variables that control important aspects of our vpc,
most importantly ( as least for me ) tenancy. This will be
set to "default".
link to the variables to _3_vpc.tf
*/

resource "aws_vpc" "elluis_vpc" {
  cidr_block = var.elluis_vpc_cidr_block
}

resource "aws_internet_gateway" "elluis_internet_gateway" {
  vpc_id = aws_vpc.elluis_vpc.id
  tags = local.default_tags
}

resource "aws_subnet" "public" {
  for_each = var.azs
  cidr_block = cidrsubnet(var.elluis_vpc_cidr_block, 8, each.value + 32)
  availability_zone = format("%s%s", local.region_name, each.key)
  map_public_ip_on_launch = true
  vpc_id = aws_vpc.elluis_vpc.id

  # name resource according to project name, az, and region
  # merging the tag allows us to carry this information to the next resource
  tags    = merge(
          local.default_tags,
  {
    Name      = format("%s-%s-%s", upper(var.env_prefix), lookup(var.region_az_short_names,
              format("%s%s", local.region_name, each.key)),
              local.public_label)
  }
  )

}