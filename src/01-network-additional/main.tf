################################################################################
# VPC Endpoints
#
# Depende da VPC e da route table pública criadas na 00-foundation.
################################################################################
module "vpc-endpoints" {
  source                = "./modules/10-vpc-endpoints"
  platform              = var.platform
  application           = var.application
  env                   = var.env
  region                = var.region
  vpc_id                = data.terraform_remote_state.foundation.outputs.vpc_id
  route_table_public_id = data.terraform_remote_state.foundation.outputs.route_table_public_id
}

################################################################################
# Network ACL — regras de borda das subnets públicas
################################################################################
module "network-acl" {
  source                 = "./modules/20-network-acl"
  platform               = var.platform
  application            = var.application
  env                    = var.env
  vpc_id                 = data.terraform_remote_state.foundation.outputs.vpc_id
  subnet_ids             = data.terraform_remote_state.foundation.outputs.subnet_public_ids
  cidr_permitido_interno = var.cidr_permitido_interno
}
