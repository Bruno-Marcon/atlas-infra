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

variable "log_retencao_dias" {
  description = "Retenção dos log groups"
  type        = number
}

variable "sns_infra_arn" {
  description = "Tópico de notificação da camada 00-foundation"
  type        = string
}
