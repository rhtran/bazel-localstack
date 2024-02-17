module "vpc" {
  source = "../modules/vpc"
}

module "server" {
  # path to the module's directory
  source = "../modules/server"

  # module inputs
  vpc_id      = module.vpc.main_vpc_id
  subnet_id   = module.vpc.web_subnet_id
  server_type = var.server_type
  public_key  = var.public_key
  script_name = var.script_name
}

