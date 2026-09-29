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

variable "log_retencao_dias" {
  description = "Retenção dos log groups da aplicação"
  type        = number
}

variable "parametros_aplicacao" {
  description = "Parâmetros de configuração publicados no parameter store"
  type        = map(string)
}

variable "service_accounts" {
  description = "Service accounts do cluster que ganham role própria (namespace => nome)"
  type        = map(string)
}

variable "habilitar_addons" {
  description = "Liga os add-ons gerenciados do EKS (o emulador local não implementa a API)"
  type        = bool
  default     = false
}
