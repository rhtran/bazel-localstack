/*
Challenge #11

  Consider the solution to the last challenge.
  Change the code to start an Ubuntu Server instead of Amazon Linux 2. Take the Ubuntu AMI from the AWS Management Console.
  Connect using SSH to the Ubuntu Server using the username called ubuntu

  Test your solution and then destroy the entire infrastructure.
*/
resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/24"
  tags = {
    "Name" = "Production VPC"
  }
}