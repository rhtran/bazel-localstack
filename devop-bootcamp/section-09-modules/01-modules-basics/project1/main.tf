module "myec2" {
  # path to the module's directory
  source = "../modules/ec2"

  # module inputs
  ami_id        = var.ami_id
  instance_type = var.instance_type
  servers       = var.servers
}