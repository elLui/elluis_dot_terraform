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
  # allows any 2.x version of AWS provider
  version = var.aws_version
}

# create aws vpc for elluis.codes
resource "aws_vpc" "elluis_codes_vpc" {
  cidr_block = var.elluis_codes_vpc_cidr_block
}

# set-up default launch server
resource "aws_launch_configuration" "elluis_server" {
  # current ==  ami-0a91cd140a1fc148a
  # Ubuntu Server 20.04 LTS (HVM),EBS General Purpose (SSD) Volume Type. Support available from Canonical (http://www.ubuntu.com/cloud/services).
  # free tier eligible
  image_id = var.server_ami

  # Gb == gigabit // GB == gigabyte
  # t2.micro is free tier eligible
  # starting at t3 network connectivity goes up to 5Gb
  # alternative t3.nano(vCPUS = 2, Memory = 0.5GB)
  # alternative t3.micro(vCPUS = 2, Memory = 1GB)
  # alternative t3.na(vCPUS = 2, Memory = 2GB)
  instance_type = var.server_instance_type

  # 
  security_groups = [
    aws_security_group]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF


}
resource "aws_instance" "example" {
  # image aws ami
  ami = "ami-0c55b159cbfafe1f0"
  # t2.micro (free tier)
  instance_type = "t2.micro"
  associate_public_ip_address = true

  # place the server inside elluis_server security group 
  vpc_security_group_ids = [
    aws_security_group]



  # this will create and serve index.html file
  # via built in ubuntu 16 lts server

  # notice that the server busy box commands are wrapped
  # by nohub commands are -here -yep -ok &
  # this allows the server to run permanently in
  # in the background but exit out of the bash script

  # EOF is terraform multi-line comment without having
  # to insert multiple /n 
  user_data = <<-EOF
                #!/bin/bash
                echo "hello, elluis" > index.html
                nohub busybox httpd -f -p ${var.server_port}  &
                EOF
  tags = {
    "Name" = "elluis_server"
  }
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