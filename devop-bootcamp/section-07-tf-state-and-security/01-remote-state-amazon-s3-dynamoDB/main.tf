# Create an EC2 instance
resource "aws_instance" "server" {
  ami           = "ami-05cafdf7c9f772ad2"
  instance_type = "t2.micro"
}