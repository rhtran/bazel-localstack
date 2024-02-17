/*
Challenge #7

  Consider the following Terraform configuration file used
  to provision two identical resources of type AWS EC2 instance.
  Declare output values to print out both the public and the private IP addresses of both instances.

  Test your solution and then destroy the entire infrastructure.
*/

resource "aws_instance" "server" {
  ami           = "ami-04a50faf2a2ec1901"
  instance_type = "t2.micro"
  count         = 2
}