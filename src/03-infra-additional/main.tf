################################################################################
# OIDC do cluster e roles por service account (IRSA)
#
# Primeiro módulo da camada: é a identidade que todo o resto do cluster usa.
################################################################################
module "k8s-oidc" {
  source              = "./modules/10-k8s-oidc"
  platform            = var.platform
  application         = var.application
  env                 = var.env
  cluster_oidc_issuer = data.terraform_remote_state.infra.outputs.cluster_oidc_issuer
  service_accounts    = var.service_accounts
}

################################################################################
# Observabilidade — log groups e fila de notificação
################################################################################
module "observabilidade" {
  source            = "./modules/20-observabilidade"
  platform          = var.platform
  application       = var.application
  env               = var.env
  log_retencao_dias = var.log_retencao_dias
  sns_infra_arn     = data.terraform_remote_state.foundation.outputs.sns_infra_arn
}

################################################################################
# Add-ons gerenciados do cluster
#
# Desligado no sandbox — ver a limitação documentada em modules/30-k8s-addons.
################################################################################
module "k8s-addons" {
  source       = "./modules/30-k8s-addons"
  platform     = var.platform
  application  = var.application
  env          = var.env
  cluster_name = data.terraform_remote_state.infra.outputs.cluster_name
  habilitar    = var.habilitar_addons
}

################################################################################
# Segredos e parâmetros da aplicação
################################################################################
module "secrets" {
  source               = "./modules/40-secrets"
  platform             = var.platform
  application          = var.application
  env                  = var.env
  app_role_arn         = data.terraform_remote_state.infra.outputs.app_role_arn
  parametros_aplicacao = var.parametros_aplicacao
}

################################################################################
# Certificado TLS do ambiente
################################################################################
module "tls-certificados" {
  source      = "./modules/50-tls-certificados"
  platform    = var.platform
  application = var.application
  env         = var.env
  zone_id     = data.terraform_remote_state.infra.outputs.zone_id
  dominio     = data.terraform_remote_state.infra.outputs.zone_name
}
