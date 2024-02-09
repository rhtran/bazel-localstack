# Create an EC2 instance
resource "aws_instance" "server" {
  ami = "ami-06ec8443c2a35b0ba"
  instance_type = "t2.micro"
  tags = {
    "Name" = "server"
  }
}