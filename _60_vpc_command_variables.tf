# define main cidr_block
variable "elluis_vpc_cidr_block" {
  description   = "main vpc cidr block"
  type          = string
  default       = "64.0.0.0/16"
}
# warning this can greatly influence your weight loss diet - set to "default"
# in our use case is going to be false
variable "instance_tenancy" {
  description   = "!!!!!!!! this can cost you mucho dinero !!!!!!!!!!!!"
  type          = string
  default       = "default"
}
#
variable "enable_dns_hostnames" {
  description = "enable dns hostnames"
  type          = bool
  default       = true
}
#
variable "enable_dns_support" {
  description = "enable dns support"
  type          = bool
  default       = true
}
#
variable "enable_classiclink" {
  description   = "enable classiclink for legacy system"
  type          = bool
  default       = false
}