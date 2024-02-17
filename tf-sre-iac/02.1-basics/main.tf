# Terraform Setting Block
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

# Provider Block
provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

# Resource Block
resource "aws_instance" "ec2demo" {
  ami           = "ami-0533f2ba8a1995cf9" # Amazon Linux in us-east-1, update as per your region
  instance_type = "t2.micro"
}