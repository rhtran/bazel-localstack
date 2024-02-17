/*
Challenge #3
  Provision a new subnet for the production VPC with the local name webapps
  Set the IPv4 CIDR block for the subnet to 192.168.0.32/27
  Set the availability zone for the subnet to us-west-1b
  Tag the new resource and use the key-value map Name = "Web Applications Subnet"
  Apply the configuration to provision the infrastructure on AWS.
  Go to the AWS Management Console -> VPC Dashboard and notice that both the VPC and the subnet were provisioned.
  Test your solution and then destroy the entire infrastructure.
*/
# Create a VPC
resource "aws_vpc" "production" {
  cidr_block = "192.168.0.0/24"
  tags = {
    "Name" = "Production VPC"
  }
}

variable "web_apps_subnet" {
  default     = "192.168.0.32/27"
  description = "Web Applications Subnet"
  type        = string
}

# Create a subnet in the VPC
resource "aws_subnet" "webapp" {
  vpc_id            = aws_vpc.production.id
  cidr_block        = var.web_apps_subnet
  availability_zone = "us-west-1b"
  tags = {
    "Name" = "Web Applications Subnet"
  }
}