# main terra form file for elluis blog network infrastructure
# details:
#     us-east-2
# @author luis_cortez elluis.codes@gmail.com
# @version 0.01


# prior to running this script through terraform
# ensure proper aws credentials are supplied
# developer has local environment setup
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

# basic template -
# create security group template
resource "aws_security_group" "instance" {
  name = "terra-example-instance"
  ingress {
    from_port = var.server_port
    to_port = var.server_port
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
}

# output variables
output "public_ip" {
  value = aws_instance.example.public_ip
  description = "public ip address of our test server"
}