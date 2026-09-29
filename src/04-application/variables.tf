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

variable "storage_config" {
  description = "Configuração do bucket da aplicação"
  type = object({
    versionamento     = bool
    expiracao_dias    = number
    transicao_ia_dias = number
  })
}

variable "fila_config" {
  description = "Configuração da fila de trabalho"
  type = object({
    visibilidade_s = number
    retencao_s     = number
    max_tentativas = number
  })
}

variable "registros_dns" {
  description = "Nomes publicados na zona do ambiente (subdomínio => alvo; vazio aponta para o cluster)"
  type        = map(string)
}
