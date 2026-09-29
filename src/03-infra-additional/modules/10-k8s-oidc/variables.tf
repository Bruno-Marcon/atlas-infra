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

variable "cluster_oidc_issuer" {
  description = "Issuer OIDC do cluster, vindo da camada 02-infra"
  type        = string
}

variable "service_accounts" {
  description = "Service accounts que ganham role própria (namespace => nome)"
  type        = map(string)
}
