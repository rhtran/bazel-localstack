/*
Challenge #12
  Change the solution to the last challenge s
  o that Terraform spins up the latest version of the Ubuntu Server.
  Use a data source to fetch the latest version of Ubuntu.

  Test your solution and then destroy the entire infrastructure.
*/
resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/24"
  tags = {
    "Name" = "Production VPC"
  }
}