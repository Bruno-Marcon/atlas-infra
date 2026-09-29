################################################################################
# DNS — zona privada do ambiente
#
# Primeiro módulo da camada: cluster, banco e certificado publicam nome aqui.
################################################################################
module "dns-zone" {
  source      = "./modules/09-dns-zone"
  platform    = var.platform
  application = var.application
  env         = var.env
  vpc_id      = data.terraform_remote_state.foundation.outputs.vpc_id
  dominio     = var.dominio
}

################################################################################
# IAM — identidade da aplicação e as duas roles do cluster
################################################################################
module "iam" {
  source          = "./modules/10-iam"
  platform        = var.platform
  application     = var.application
  env             = var.env
  audit_bucket_id = data.terraform_remote_state.foundation.outputs.audit_bucket_id
}

################################################################################
# Databases — banco relacional (com senha no cofre) e tabelas NoSQL
################################################################################
module "databases" {
  source             = "./modules/40-databases"
  platform           = var.platform
  application        = var.application
  env                = var.env
  databases_config   = var.databases_config
  rds_config         = var.rds_config
  subnet_ids         = data.terraform_remote_state.foundation.outputs.subnet_private_ids
  security_group_ids = [data.terraform_remote_state.foundation.outputs.security_group_app_id]
}

################################################################################
# Kubernetes — cluster e nodegroup
#
# Depende das roles do módulo 10-iam e das subnets privadas da 00-foundation.
################################################################################
module "kubernetes" {
  source             = "./modules/50-kubernetes"
  platform           = var.platform
  application        = var.application
  env                = var.env
  cluster_role_arn   = module.iam.eks_cluster_role_arn
  node_role_arn      = module.iam.eks_node_role_arn
  subnet_ids         = data.terraform_remote_state.foundation.outputs.subnet_private_ids
  security_group_ids = [data.terraform_remote_state.foundation.outputs.security_group_app_id]
  kubernetes_config  = var.kubernetes_config
}

################################################################################
# Container Registry — um repositório por componente
################################################################################
module "container-registry" {
  source       = "./modules/60-container-registry"
  platform     = var.platform
  application  = var.application
  env          = var.env
  repositorios = var.repositorios_imagem
}

################################################################################
# Cache em memória
################################################################################
module "cache" {
  source             = "./modules/80-cache"
  platform           = var.platform
  application        = var.application
  env                = var.env
  subnet_ids         = data.terraform_remote_state.foundation.outputs.subnet_private_ids
  security_group_ids = [data.terraform_remote_state.foundation.outputs.security_group_app_id]
  cache_config       = var.cache_config
}
