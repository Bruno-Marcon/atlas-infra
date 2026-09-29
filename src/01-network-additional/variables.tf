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

variable "cidr_permitido_interno" {
  description = "CIDR liberado nas regras de entrada da ACL"
  type        = string
}
