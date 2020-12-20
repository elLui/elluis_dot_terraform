variable "region_az_short_names" {
  description = "convert short names to full name of region or zone"
  type = map(string)

  default = {
    us-east-2 = "us_east_2"
    us-east-2a = "us_east_2a"
    us-east-2b = "us_east_2b"
    us-east-2c = "us_east_2c"
  }
}

variable "env_prefix" {
  description = "name of coding project stage infrastructure"
  type = string
  default = "elluis_codes_limited_network"
}



variable "azs" {
  description = "3rd octet subnet number"
  type                = map(number)
  default = {
    a = 11
    b = 22
    c = 33
  }
}

variable "aws_region" {
  description = "aws deployment region"
  default = "us-east-2"
}

# version can not be declared as a variable
variable "aws_version" {
  description = "current aws version"
  default = "~> 2.70"
}