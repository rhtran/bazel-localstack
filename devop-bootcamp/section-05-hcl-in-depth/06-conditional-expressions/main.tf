# Creating the test-server instance if `istate` equals true
resource "aws_instance" "test-server" {
  ami           = "ami-05cafdf7c9f772ad2"
  instance_type = "t2.micro"
  count         = var.istest == true ? 1 : 0 # conditional expression
}

## Creating the prod-server instance if `istate` equals false
resource "aws_instance" "prod-server" {
  ami           = "ami-05cafdf7c9f772ad2"
  instance_type = "t2.large"                  # it's not free tier eligible
  count         = var.istest == false ? 1 : 0 # conditional expression
}