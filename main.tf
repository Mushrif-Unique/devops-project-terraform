# ----------------------------------------
# Networking Module
# ----------------------------------------

module "networking" {
  source = "./modules/networking"

  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
  project_name       = var.project_name
  environment        = var.environment
}


# ----------------------------------------
# Compute Module
# ----------------------------------------

module "compute" {
  source = "./modules/compute"

  ami_id        = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = module.networking.public_subnet_id
  vpc_id        = module.networking.vpc_id
  key_name      = var.key_name
  public_key    = file("C:/Users/MUSHR/.ssh/Demo1_generated.pub")
  project_name  = var.project_name
  environment   = var.environment
}