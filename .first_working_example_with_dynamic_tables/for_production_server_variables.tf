
variable "env_prefix" {
  description = "alpha creation terraform build"
  type = string
  default = "elluis_codes"
}

variable "region_az_short_names" {
  description = "region and az names"
  type = map(string)

  default = {
    us-east-2 = "us_east_2"
    us-east-2a = "us_east_2a"
    us-east-2b = "us_east_2b"
    us-east-2c = "us_east_2c"
  }
}

variable "cidr_block" {
  description = "64.0.0.0/16 block provides 65_536 unique ip address"
  type = string
  default = "64.0.0.0/16"
}

//variable "region_az_short_names__" {
//  description = "az(letter) to subnet (3rd octet)"
//  type = map(number)
//}

variable "vpc_tenancy" {
  description = "set vpc tenancy"
  type = string
  default = "default"
}

variable "azs" {
  description = "AZ (letter) to Subnet (number for 3rd octet)"
  type        = map(number)
  default = {
    a = 1
    b = 2
    c = 3
  }
}