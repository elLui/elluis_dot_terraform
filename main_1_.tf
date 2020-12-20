/*
after learning terraform for 2 days - second attempt at building my
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
