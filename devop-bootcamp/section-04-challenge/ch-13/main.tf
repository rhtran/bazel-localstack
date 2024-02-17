/*
Challenge #13

  Consider the solution to the last challenge.
  Add the Terraform code that initializes the server at boot as follows:
  install the latest Apache2 web server.
  add a new group called terraform
  add a new username called backup-user. It should belong to admin and terraform groups.
  make sure port 80 is open for ingress traffic.
  Write all the initialization commands in a script.

  Test your solution and then destroy the entire infrastructure.
*/

resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/24"
  tags = {
    "Name" = "Production VPC"
  }
}