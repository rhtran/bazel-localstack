/*
Challenge #10

  Consider the solution to the last challenge.
  Add the Terraform code that prints out at the terminal both the public and the private IP addresses of the instance.

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
  ingress {
    from_port   = 80
    to_port     = 80
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

# Creating a key-pair resource
resource "aws_key_pair" "production_key" {
  key_name   = "prod_ssh_key"
  public_key = file(var.ssh_public_key)


}

# Spinning up an EC2 Instance
resource "aws_instance" "server" {
  ami           = "ami-04a50faf2a2ec1901"
  instance_type = "t2.micro"

  subnet_id                   = aws_subnet.web.id
  vpc_security_group_ids      = [aws_default_security_group.default_sec_group.id]
  associate_public_ip_address = true
  key_name                    = "prod_ssh_key"

  tags = {
    "Name" = "My EC2 Intance - Amazon Linux 2"
  }
}

### SOLUTION ###
# 1. Generate your own SSH keys on Linux by running: ssh-keygen -t rsa -b 2048 -C 'your comment' -N '' -f ./prod_rsa

# 2. Connect to the server by running: ssh -i ./prod_rsa ec2-user@EC2_PUBLIC_IP
# Note: You may find the EC2 public ip on the EC2 Dashboard