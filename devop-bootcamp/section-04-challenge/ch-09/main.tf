/*
Challenge #9

  Consider the following partial Terraform configuration.
  Generate an SSH key pair for authentication.
  Add the Terraform code that will spin up an EC2 instance in the VPC.
  Run the latest version of Amazon Linux 2 or use amid="ami-04a50faf2a2ec1901"

  Set the instance type to t2.micro
  Associate the Default Security Group to the instance.
  Configure the instance to use the SSH key pair you've just created for authentication.
  Associate a public IP address to the instance.
  Apply the configuration and test that you can connect to the instance using SSH and the key pair. Find the public IP address of the instance on AWS Web Console.

  Test your solution and then destroy the entire infrastructure.
*/

# Creating a VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    "Name" = "Production ${var.main_vpc_name}" # string interpolation
  }
}

# Creating a subnet in the VPC
resource "aws_subnet" "web" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.web_subnet
  availability_zone = var.subnet_zone
  tags = {
    "Name" = "Web subnet"
  }
}

# Creating an Intenet Gateway
resource "aws_internet_gateway" "my_web_igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "${var.main_vpc_name} IGW"
  }
}

#  Associating the IGW to the default RT
resource "aws_default_route_table" "main_vpc_default_rt" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0" # default route
    gateway_id = aws_internet_gateway.my_web_igw.id
  }
  tags = {
    "Name" = "my-default-rt"
  }
}

# Default Security Group
resource "aws_default_security_group" "default_sec_group" {
  vpc_id = aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    "Name" = "Default Security Group"
  }
}