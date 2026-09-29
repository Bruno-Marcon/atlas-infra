################################################################################
# Storages da aplicação
#
# O log de acesso vai para o bucket de auditoria da 00-foundation — é o elo que
# faz a camada de aplicação herdar a política de retenção da fundação.
################################################################################
module "storages" {
  source          = "./modules/30-storages"
  platform        = var.platform
  application     = var.application
  env             = var.env
  storage_config  = var.storage_config
  audit_bucket_id = data.terraform_remote_state.foundation.outputs.audit_bucket_id
}

################################################################################
# Filas de trabalho
################################################################################
module "filas" {
  source        = "./modules/50-filas"
  platform      = var.platform
  application   = var.application
  env           = var.env
  fila_config   = var.fila_config
  sns_infra_arn = data.terraform_remote_state.foundation.outputs.sns_infra_arn
}

################################################################################
# DNS da aplicação
#
# Fecha a cadeia: usa a zona e o cluster da 02-infra para publicar o nome pelo
# qual a aplicação é alcançada dentro da VPC.
################################################################################
module "dns" {
  source           = "./modules/50-dns"
  platform         = var.platform
  application      = var.application
  env              = var.env
  zone_id          = data.terraform_remote_state.infra.outputs.zone_id
  zone_name        = data.terraform_remote_state.infra.outputs.zone_name
  cluster_endpoint = data.terraform_remote_state.infra.outputs.cluster_endpoint
  registros        = var.registros_dns
}
