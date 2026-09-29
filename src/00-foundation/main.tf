################################################################################
# Network
################################################################################
module "network" {
  source      = "./modules/10-aws-network"
  platform    = var.platform
  application = var.application
  env         = var.env
  cidr_subnet = var.cidr_subnet
}

################################################################################
# SNS — tópico de notificação de infraestrutura
################################################################################
module "sns-topic" {
  source            = "./modules/70-aws-sns-topic"
  platform          = var.platform
  application       = var.application
  env               = var.env
  notificacao_email = var.notificacao_email
}

################################################################################
# Audit Storage — bucket de auditoria e seus access logs
################################################################################
module "audit-storage" {
  source               = "./modules/110-aws-audit-storage"
  platform             = var.platform
  application          = var.application
  env                  = var.env
  audit_storage_config = var.audit_storage_config
}
