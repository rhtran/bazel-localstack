# Creating multiple EC2 instances using count
resource "aws_instance" "server" {
  ami           = "ami-06ec8443c2a35b0ba"
  instance_type = "t2.micro"
  count         = 3 # creating 3 resources
}
