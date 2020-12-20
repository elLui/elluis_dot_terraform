# vpc construction
resource "aws_vpc" "elluis_vpc" {
  cidr_block                    = var.elluis_vpc_cidr_block
  instance_tenancy              = var.instance_tenancy
  enable_dns_hostnames          = var.enable_dns_hostnames
  enable_dns_support            = var.enable_dns_support
  enable_classiclink            = var.enable_classiclink
}

# internet gateway construction attached to vpc
resource "aws_internet_gateway" "elluis_internet_gateway" {
  # attach to elluis_vpc
  vpc_id                        = aws_vpc.elluis_vpc.id
  # begin collecting naming and counting data for cidr and az assignments
  # by using tag created in _2_local_var_creator.tf
  tags                          = local.default_tags
}
# developer mode switch
# I will only be creating one nat-gateway instead of all nat-gateways
# this nat-gateway will be attached to us-east-2c private subnet
# creates a nat-gateway named after the resource it is attached to
resource "aws_nat_gateway" "elluis_nat_gateway" {
  for_each = var.azs

  allocation_id = lookup(aws_eip.nat_ips, each.key).id
  subnet_id = lookup(aws_subnet.public, each.key).id
  tags = merge(
  local.default_tags,
  {
    Name = format(
    "%s-%s-%s",
    upper(var.env_prefix),
    lookup(var.region_az_short_names, format("%s%s", local.region_name, each.key)),
    local.nat_gw_label
    )
  },
  )
}

# assigns elastic (eip) ip to every nat-gateway to keep db ip address constant
  resource "aws_eip" "nat_ips" {
    for_each = var.azs

    vpc = true
    tags = merge(
    local.default_tags,
    {
      Name = format(
      "%s-%s-%s",
      upper(var.env_prefix),
      lookup(var.region_az_short_names, format("%s%s", local.region_name, each.key)),
      local.nat_gw_label
      )
    }
    )
  }

  # create public subnets in each az
  resource "aws_subnet" "public" {
    #_1_ for every availability zone
    for_each = var.azs
    #_2_ create a new subnet adding 32 to the value
    cidr_block = cidrsubnet(var.elluis_vpc_cidr_block, 8, each.value + 32)
    # assign availability zone        #us-east-2          # a , b, c :: as mapped in our variables
    # following values are assigned to the public az's
    availability_zone = format("%s%s", local.region_name, each.key)
    # us_east_2*
    map_public_ip_on_launch = true
    vpc_id = aws_vpc.elluis_vpc.id

    # name resource according to project name, az, and region
    # merging the tag allows us to carry this information to the next resource
    tags = merge(
    local.default_tags,
    {
      # tags our subnets with the appropriate 'Name'
      # ELLUIS_CODES_LIMITED_NETWORK-us_east_2a-elluis_public
      # ELLUIS_CODES_LIMITED_NETWORK-us_east_2b-elluis_public
      # ELLUIS_CODES_LIMITED_NETWORK-us_east_2c-elluis_public

      # creates our format template - be careful pay attention to commas!
      Name = format("%s-%s-%s", upper(var.env_prefix),
      lookup(var.region_az_short_names,
      # this puts together our us-east2 with a/b/c
      format("%s%s", local.region_name, each.key)),
      # finally attaching our elluis_public tag at the end
      local.public_label)
    }
    )
  }

# create public subnets in each az
resource "aws_subnet" "private" {
  for_each = var.azs
  # ensure that the final value entered in our cidrsubnet does not match our public subnets
  cidr_block                    = cidrsubnet(var.elluis_vpc_cidr_block, 8, each.value)
  availability_zone             = format("%s%s", local.region_name, each.key)
  map_public_ip_on_launch       = true
  vpc_id                        = aws_vpc.elluis_vpc.id

  tags                          = merge(
  local.default_tags,
  {
                                # following values are assigned to the public az's
                                # ELLUIS_CODES_LIMITED_NETWORK-us_east_2a-elluis_private
                                # ELLUIS_CODES_LIMITED_NETWORK-us_east_2b-elluis_private
                                # ELLUIS_CODES_LIMITED_NETWORK-us_east_2c-elluis_private
    Name                        = format("%s-%s-%s", upper(var.env_prefix),   # ELLUIS_CODES_LIMITED_NETWORK
                                lookup(var.region_az_short_names,             # us_east_2
                                format("%s%s", local.region_name, each.key)), # a - b -c
                                local.private_label)                          # elluis_private
  }
  )
}