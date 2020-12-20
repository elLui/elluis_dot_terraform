/*
after learning terraform for 2 days - second attempt at building my


if you see an empty comment space ie.

# it is usually because the function/resource/variable/etc explains itself




portfolio // blog infrastructure
@author luis_cortez elluis.codes@gmail.com
@version 0.02
*/
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

# provide default aws cli and region information
provider "aws" {
  region = var.aws_region
}