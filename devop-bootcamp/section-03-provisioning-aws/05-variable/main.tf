# Configure the variables
variable "vpc_cidr_block" {
  default     = "10.0.0.0/16"
  description = "CIDR Block for the VPC"
  type        = string
}

variable "web_subnet" {
  default     = "10.0.10.0/24"
  description = "Web Subnet"
  type        = string
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
  tags = {
    "Name" = "Main VPC"
  }
}

# Create a subnet in the VPC
resource "aws_subnet" "web" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.web_subnet
  availability_zone = "us-east-1a"
  tags = {
    "Name" = "Web subnet"
  }
}
