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

variable "app_role_arn" {
  description = "Role da aplicação, criada na camada 02-infra"
  type        = string
}

variable "parametros_aplicacao" {
  description = "Parâmetros de configuração (não-sensíveis) da aplicação"
  type        = map(string)
}
