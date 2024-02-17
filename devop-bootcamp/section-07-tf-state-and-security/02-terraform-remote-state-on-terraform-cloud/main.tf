# Create a VPC.
resource "aws_vpc" "new" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" = "New DevOps VPC"
  }
}