//cidr_block configuration summary:
//
//vpc = 64.0.0.0/16
//subnets = 6 (this provides each subnet with 8_192 ip addresses)
//subnet mask = 255.255.224.0 (this covers all subnets)
//
//        subnet_number:  1
//        subnet:         64.0.0.0/19
//        mask:           255.255.224.0
//        range:          64.0.0.0 - 64.0.31.255
//TODO :: format subnets description once it is implemented
//2
//64.0.32.0/19
//255.255.224.0
//64.0.32.0 - 64.0.63.255
//2^13 (= 8 192 )
//3
//64.0.64.0/19
//255.255.224.0
//64.0.64.0 - 64.0.95.255
//2^13 (= 8 192 )
//4
//64.0.96.0/19
//255.255.224.0
//64.0.96.0 - 64.0.127.255
//2^13 (= 8 192 )
//5
//64.0.128.0/19
//255.255.224.0
//64.0.128.0 - 64.0.159.255
//2^13 (= 8 192 )
//6
//64.0.160.0/19
//255.255.224.0
//64.0.160.0 - 64.0.191.255
//2^13 (= 8 192 )

// main.tf setup
variable "aws_region" {
  description = "aws deployment region"
  default = "us-east-2"
}
variable "aws_version" {
  description = "current aws version"
  default = "~> 2.70"
}
variable "elluis_codes_vpc_cidr_block" {
  description = "64.0.0.0/16 block provides 65_536 unique ip address"
  type = string
  default = "64.0.0.0/16"
}
variable "instance_tenancy" {
  description = "!!!!!!!! this can cost you mucho dinero !!!!!!!!!!!!"
  type = string
  default = "default"
}
variable "enable_dns_hostnames" {
  description = "enable dns hostnames"
  type = bool
  default = true
}
variable "enable_dns_support" {
  description = "enable dns support"
  type = bool
  default = true
}
variable "enable_classiclink" {
  description = "enable classic link"
  type = bool
  default = false
}
variable "tags" {
  description = "map of tags to ad to all resources"
  type = string
  default = "elluis_codes_terraform_v1"
}