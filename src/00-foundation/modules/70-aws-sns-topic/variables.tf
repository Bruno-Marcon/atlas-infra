variable "platform" {
  description = "Nome da plataforma"
  type        = string
}

variable "application" {
  description = "Nome da aplicação"
  type        = string
}

variable "env" {
  description = "Nome do ambiente (dev, hmg ou prd)"
  type        = string
}

variable "notificacao_email" {
  description = "Destinatário das notificações de infraestrutura"
  type        = string
}
