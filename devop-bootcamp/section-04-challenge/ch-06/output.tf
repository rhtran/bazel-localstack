output "ec2_public_ip" {
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.server.public_ip
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_instance.server.id
  sensitive   = false
}

output "ami_id" {
  description = "ID of AMI"
  value       = aws_instance.server.ami
  sensitive   = false
}