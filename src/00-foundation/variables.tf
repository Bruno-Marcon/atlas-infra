################################################################################
# Variáveis da camada
#
# platform/application/env formam o prefixo canônico de todo recurso:
#   <platform>-<application>-<env>-<tipo>   ex.: sbx-atlas-hmg-artifacts
################################################################################
variable "platform" {
  description = "Nome da plataforma"
  type        = string
  default     = "sbx"
}

variable "application" {
  description = "Nome da aplicação"
  type        = string
  default     = "atlas"
}

variable "env" {
  description = "Nome do ambiente (dev, hmg ou prd)"
  type        = string

  validation {
    condition     = contains(["dev", "hmg", "prd"], var.env)
    error_message = "env precisa ser dev, hmg ou prd."
  }
}

variable "region" {
  description = "Região da nuvem"
  type        = string
  default     = "us-east-1"
}

variable "endpoint_local" {
  description = "Endpoint do emulador local; vazio aponta para a nuvem real"
  type        = string
  default     = "http://localhost:4566"
}

variable "cidr_subnet" {
  description = "Dois primeiros octetos do CIDR da VPC (ex.: 10.10)"
  type        = string
}

variable "audit_storage_config" {
  description = "Configuração do bucket de auditoria"
  type = object({
    retencao_dias = number
    versionamento = bool
  })
}

variable "notificacao_email" {
  description = "Destinatário das notificações de infraestrutura"
  type        = string
}
