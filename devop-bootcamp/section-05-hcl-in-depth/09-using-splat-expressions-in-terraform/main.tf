# Create an EC2 instance
resource "aws_instance" "server" {
  ami           = "ami-05cafdf7c9f772ad2"
  instance_type = "t2.micro"
  count         = 3
}

output "private_addresses" {
  value = aws_instance.server[*].private_ip # splat expression
}

# output "private_address2"{
#   value = aws_instance.server[1].private_ip
# }

# output "private_address3"{
#   value = aws_instance.server[2].private_ip
# }