/*
Challenge #14
  Change the solution to the previous challenge so that only
  your public IP address is allowed to connect to SSH (port 22).
  Find out your own public IP address on https://ident.me/
  Test your solution and then destroy the entire infrastructure.
*/

resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/24"
  tags = {
    "Name" = "Production VPC"
  }
}