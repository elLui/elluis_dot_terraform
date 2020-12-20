/*TODO ::

*/
# vpc construction
resource "aws_vpc" "elluis_vpc" {
  cidr_block = var.elluis_vpc_cidr_block
  instance_tenancy = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support
  enable_classiclink = var.enable_classiclink
}
# internet gateway construction
resource "aws_internet_gateway" "elluis_internet_gateway" {
  # attach to elluis_vpc
  vpc_id = aws_vpc.elluis_vpc.id
  # begin collecting naming and counting data for cidr and az assignments
  # by using tag created in _2_local_var_creator.tf
  tags = local.default_tags
}
# create public subnets
resource "aws_subnet" "public" {
  #_1_ for every availability zone
  for_each = var.azs
                                                        #_2_ create a new subnet adding 32 to the value
  cidr_block = cidrsubnet(var.elluis_vpc_cidr_block, 8, each.value + 32)
  # assign availability zone        #us-east-2          # a , b, c :: as mapped in our variables
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