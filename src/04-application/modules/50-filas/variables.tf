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

variable "fila_config" {
  description = "Visibilidade, retenção e número máximo de tentativas"
  type = object({
    visibilidade_s = number
    retencao_s     = number
    max_tentativas = number
  })
}

variable "sns_infra_arn" {
  description = "Tópico de notificação da camada 00-foundation"
  type        = string
}
