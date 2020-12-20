
variable "aws_region" {
  description = "aws deployment region"
  default = "us-east-2"
}

# version can not be declared as a variable
variable "aws_version" {
  description = "current aws version"
  default = "~> 2.70"
}