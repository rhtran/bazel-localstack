/*
Challenge #2

  Provision a new resource of type AWS VPC called production
  Set the IPv4 CIDR block for the VPC to 192.168.0.0/24
  Tag the new resource and use the key-value map Name = "Production VPC"
  Run terraform init, terraform plan and terraform apply to provision the VPC.
  Go to the AWS Management Console -> Select "us-west-1" Region -> VPC Dashboard and notice that the new VPC was created.
  Change the AWS region to another one and notice that the VPC does not exist in the new region.

  Test your solution and then destroy the entire infrastructure.
  Are you stuck? Do you want to see the solution to this challenge?
  Click [here](https://drive.google.com/drive/folders/1o5GYNacblJW74OqFoLVNb8D8it3XBNlo?usp=sharing).
*/
resource "aws_vpc" "production" {
  cidr_block = "192.168.0.0/24"
  tags = {
    "Name" = "Production VPC"
  }
}