/*
Challenge #5

  Consider the following Terraform configuration file which provisions
  a resource of type AWS VPC and a subnet in the VPC.
  However, when you want to apply the configuration you get some errors.
  Your job is to identify any errors and change the configuration so that it applies successfully.

  Test your solution and then destroy the entire infrastructure.
*/

# Creating a new VPC
resource "aws_vpc" "production" {
  cidr_block = "10.0.0.0/16"

  tags = {
    "Name" = "Production VPC"
  }
}

# Creating a subnet in the VPC
resource "aws_subnet" "webapps" {
  vpc_id            = aws_vpc.production.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-west-1a"

  tags = {
    "Name" = "Web Applications Subnet"
  }
}