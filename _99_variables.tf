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

variable "elluis_vpc_cidr_block" {
  description = "main vpc cidr block"
  type = string
  default = "64.0.0.0/16"
}
