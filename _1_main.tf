/*
this is a learning project for me

after learning terraform for 2 days - second attempt at building my infrastructure

##################################################### a few notes ######################################################
if you see an empty comment space ie.
# it is usually because the function/resource/variable/etc explains itself
# there is quite a few topics

########################################################################################################################
***************** there are some pretty specific explanations regarding a few of the trickier aspects ******************
#   having said that - there will be a few conventions that carry on throughout the code explanations for these will   #
#                                            declared in this block                                                    #
                                    :: topics are in order of construction ::

_one_ ::  explanation of tagging system can be found in _3_vpc_structure.tf
          tags are used to implement the following properties during terraform construction:
              vpc name
              create one private && public subnet in each available availability zone according to selected region
              name each subnet as follows: (vpc), (region+availability zone), (tag designating public or private subnet)
              dynamically assign ip address ranges to given subnets
              create one private and public route table in vpc
              name each route table following explained conventions





************************************************************************************************************************
########################################################################################################################
# portfolio project // blog infrastructure
# @author luis_cortez elluis.codes@gmail.com
# @version 0.02
*/
terraform {
  required_providers {
    aws           = {
      source      = "hashicorp/aws"
      version     = "~> 2.70"
    }
  }
}

# provide default aws cli and region information
provider "aws" {
  region          = var.aws_region
}