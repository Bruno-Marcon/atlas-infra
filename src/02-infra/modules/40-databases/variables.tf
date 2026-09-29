variable "platform" {
  description = "Nome da plataforma"
  type        = string
}

variable "application" {
  description = "Nome da aplicação"
  type        = string
}

variable "env" {
  description = "Nome do ambiente"
  type        = string
}

variable "databases_config" {
  description = "Modo de cobrança e backup contínuo das tabelas"
  type = object({
    billing_mode         = string
    point_in_time_backup = bool
  })
}

variable "rds_config" {
  description = "Dimensionamento e janela de backup do banco relacional"
  type = object({
    engine            = string
    instance_class    = string
    allocated_storage = number
    multi_az          = bool
    backup_retencao   = number
    deletion_protect  = bool
  })
}

variable "subnet_ids" {
  description = "Subnets privadas do grupo de sub-redes do banco"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups do banco"
  type        = list(string)
}
